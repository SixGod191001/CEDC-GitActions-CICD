import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame


def temp_org_noinsid():
    # 创建对象
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)


    # 读取 s3 source
    temp_ym = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse": True,
        }
    )

    dim_report_line = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader":True,"separator":","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path":["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    # toDF

    temp_ym_df = temp_ym.toDF()
    dim_report_line_df = dim_report_line.toDF()

    # left join  1 = 1 全表join
    join_df = temp_ym_df.join(dim_report_line_df, 1 == 1, how="left")

    # 查找想要字段
    wirte_df = join_df.selectExpr('ym','insid','brandcode','citycode','provincecode','rsm_code', 'dsm_code', 'mr_code', 'dsm', 'rsm','mr','team','region','rsd_code','rsd') \
        .dropDuplicates()

    # 写入target s3 表

    temp_org_noinsid = glueContext.write_dynamic_frame.from_options(
        frame=wirte_df,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []   # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()


