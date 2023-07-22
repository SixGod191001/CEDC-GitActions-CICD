import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession

def temp_link_dim_main_mkt_01():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    df = sk.read.csv("s3path")

    df.show()
    # 将 DataFrame 保存为 s3 target 文件
    df.write.csv("s3path")