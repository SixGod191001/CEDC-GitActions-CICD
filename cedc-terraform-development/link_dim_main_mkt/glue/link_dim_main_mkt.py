import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession


def link_dim_main_mkt():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()
    # 读取 s3 source 文件
    temp_link_dim_main_mkt_02_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    # 查找想要字段
    temp_link_dim_main_mkt_02_df.selectExpr('ym','citycode','ims_citycode','defined_mkt','brandcode','insid','insid_aspen','provincecode','rsm_code','rsm','rsd_code','rsd','region','dsm_code','dsm','mr_code','mr','team') \
        .write \
        .csv("s3 target link_dim_main_mkt table path")
