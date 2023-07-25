import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame


def temp_ym():
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)

    # 读取 s3 source
    fact_ims_city_df = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-1.csv"],
            "recurse": True,
        }
    )
    fact_cpa_df = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-2.csv"],
            "recurse": True,
        }
    )

    # to DF()
    fact_ims_city_df = fact_ims_city_df.toDF()
    fact_cpa_df = fact_cpa_df.toDF()

    # 找到列名为ym 并使用1作为join key

    fact_ims_city_df_ym = fact_ims_city_df.selectExpr('ym','1 as joinkey').dropDuplicates()
    fact_cpa_df_ym = fact_cpa_df.selectExpr('ym','1 as joinkey').dropDuplicates()

    # 进行union操作

    temp_ym_union = fact_cpa_df_ym.union(fact_ims_city_df_ym)

    temp_ym_union_DY = DynamicFrame.fromDF(temp_ym_union, glueContext ,"temp_ym_union_DY")

    # 写入 s3 target
    temp_ym = glueContext.write_dynamic_frame.from_options(
        frame=temp_ym_union_DY,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []   # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()
