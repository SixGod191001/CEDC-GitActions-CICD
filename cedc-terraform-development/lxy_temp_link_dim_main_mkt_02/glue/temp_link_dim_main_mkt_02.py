import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession


def temp_link_dim_main_mkt_02():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    temp_ym_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    dim_report_line_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    # left join  1 = 1 全表join
    join_df = temp_ym_df.join(dim_report_line_df, 1 == 1, "left")
    # 查找想要字段
    join_df.selectExpr('ym','insid','brandcode','citycode','provincecode','rsm_code', 'dsm_code', 'mr_code', 'dsm', 'rsm','mr','team','region','rsd_code','rsd') \
        .dropDuplicates \
        .write \
        .csv("s3 target temp_link_dim_main_mkt_02 table path")
