import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession


def temp_ym():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    fact_ims_city_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    fact_cpa_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    # 找到列名为ym 并使用1作为join key
    fact_ims_city_df_ym = fact_ims_city_df.selectExpr('ym','1 as joinkey')
    fact_cpa_df_ym = fact_cpa_df.selectExpr('ym','1 as joinkey')
    # 进行union操作
    temp_ym_union = fact_cpa_df_ym.union(fact_ims_city_df_ym)
    # 将 DataFrame 写入 s3 target temp_ym 文件
    temp_ym_union.write.csv("s3 target temp_ym table path")