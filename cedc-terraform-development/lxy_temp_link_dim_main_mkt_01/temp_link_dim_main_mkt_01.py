import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession

def temp_link_dim_main_mkt_01():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    fact_cpa_df = sk.read.csv("s3 source fact_cpa path",sep=',',header=True)
    dim_geography_df = sk.read.csv("s3 source dim_geography path",sep=',',header=True)
    cap_city_where = fact_cpa_df.join(dim_geography_df,(fact_cpa_df['citycode'] == dim_geography_df['citycode']),how='left') \
        .selectExpr('citycode','ims_citycode','1 as joinkey')
    cap_city = cap_city_where.where(cap_city_where['ims_citycode'].isNotNull()) \
        .dropDuplicates()
    temp_ym_df = sk.read.csv("s3 source temp_ym path",sep=',',header=True)
    main_dim = cap_city.join(temp_ym_df,(cap_city['joinkey'] == temp_ym_df['joinkey']),how='left') \
        .selectExpr('ym','citycode','ims_citycode')
    link_dim_ims_df = sk.read.csv("s3 source link_dim_ims path",sep=',',header=True)
    mkt = link_dim_ims_df.selectExpr('ym','defined_mkt','brand_code as brandcode') \
        .union(fact_cpa_df.selectExpr('ym','defined_mkt','brandcode'))
    main_dim.join(mkt,on='ym',how='left').selectExpr('ym','citycode','ims_citycode','defined_mkt','brandcode') \
        .write.csv("s3 temp_link_dim_main_mkt_01 path")