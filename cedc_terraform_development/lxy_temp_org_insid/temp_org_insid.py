import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession


def temp_org_insid():
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
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    # toDF

    temp_ym_df = temp_ym.toDF()
    dim_report_line_df = dim_report_line.toDF()

    # left join  1 = 1 全表join
    join_df = temp_ym_df.join(dim_report_line_df, 1 == 1,how="left")

    # 查找想要字段
    write_df = join_df.selectExpr('ym','insid','brandcode','citycode','provincecode','rsm_code', 'dsm_code', 'mr_code', 'dsm', 'rsm','mr','team','region','rsd_code','rsd')

    # 写入 s3 target
    temp_org_insid = glueContext.write_dynamic_frame.from_options(
        frame=write_df,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []  # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()
