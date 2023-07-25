import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession


def link_dim_main_mkt():
    # # # 创建 对象
    # # sk = SparkSession.builder \
    # #     .appName("Read data from S3 to data processing") \
    # #     .getOrCreate()
    #
    # # 读取 s3 source 文件
    # temp_link_dim_main_mkt_02_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)

    #
    # # 查找想要字段
    # temp_link_dim_main_mkt_02_df.selectExpr('ym','citycode','ims_citycode','defined_mkt','brandcode','insid','insid_aspen','provincecode','rsm_code','rsm','rsd_code','rsd','region','dsm_code','dsm','mr_code','mr','team') \
    #     .write \
    #     .csv("s3 target lxy_link_dim_main_mkt table path")

    # 创建对象
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    # spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)

    # 读取 s3 source

    temp_link_dim_main_mkt_02 = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse": True,
        }
    )

    # toDF

    temp_link_dim_main_mkt_02_df = temp_link_dim_main_mkt_02.toDF()

    # # 查找想要字段
    writer_df = temp_link_dim_main_mkt_02_df.selectExpr('ym','citycode','ims_citycode','defined_mkt','brandcode','insid','insid_aspen','provincecode','rsm_code','rsm','rsd_code','rsd','region','dsm_code','dsm','mr_code','mr','team') \

    # toDynamicFrame

    link_dim_main_mkt_DY = DynamicFrame.fromDF(writer_df, glueContext, "link_dim_main_mkt_DY")

    # 写入 s3 target
    link_dim_main_mkt = glueContext.write_dynamic_frame.from_options(
        frame=link_dim_main_mkt_DY,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []  # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()
