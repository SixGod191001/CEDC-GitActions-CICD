import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when

def temp_link_dim_main_mkt_02():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    temp_link_dim_main_mkt_01_df = sk.read.csv("s3 source temp_link_dim_main_mkt_01 path",sep=',',header=True)
    fact_cpa_df = sk.read.csv("s3 source fact_cpa path",sep=',',header=True)
    dim_party_df = sk.read.csv("s3 source dim_party path", sep=',', header=True)
    dim_geography_df = sk.read.csv("s3 source dim_geography path", sep=',', header=True)
    temp_org_insid_df = sk.read.csv("s3 source temp_org_insid path", sep=',', header=True)
    temp_org_noinsid_df = sk.read.csv("s3 source temp_org_noinsid path", sep=',', header=True)

    # 进行left join
    joined_df = temp_link_dim_main_mkt_01_df.join(
        fact_cpa_df,
        (temp_link_dim_main_mkt_01_df['ym'] == fact_cpa_df['ym']) &
        (temp_link_dim_main_mkt_01_df['defined_mkt'] == fact_cpa_df['defined_mkt']) &
        (temp_link_dim_main_mkt_01_df['brandcode'] == fact_cpa_df['brandcode']) &
        (temp_link_dim_main_mkt_01_df['citycode'] == fact_cpa_df['citycode']),
        "left"
    ).join(dim_party_df, (fact_cpa_df['insid'] == dim_party_df['insid']),'left') \
           .join(dim_geography_df,(temp_link_dim_main_mkt_01_df['citycode'] == dim_geography_df['citycode']),'left') \
           .join(temp_org_insid_df,
                 (fact_cpa_df['insid'] == temp_org_insid_df['insid']) &
                 (temp_link_dim_main_mkt_01_df['brandcode'] == temp_org_insid_df['brandcode']) &
                 (temp_link_dim_main_mkt_01_df['citycode'] == temp_org_insid_df['citycode']) &
                 (dim_geography_df['provincecode'] == temp_org_insid_df['provincecode']),'left') \
           .join(temp_org_noinsid_df,
                 (temp_link_dim_main_mkt_01_df['ym'] == temp_org_noinsid_df['ym']) &
                 (temp_link_dim_main_mkt_01_df['brandcode'] == temp_org_noinsid_df['brandcode']) &
                 (temp_link_dim_main_mkt_01_df['citycode'] == temp_org_noinsid_df['citycode']) &
                 (dim_geography_df['provincecode'] == temp_org_noinsid_df['provincecode']),'left')


    # 查找想要字段，并写入target 表
    joined_df.select(
        col("main_link.ym"),
        col("main_link.citycode"),
        col("main_link.ims_citycode"),
        col("main_link.defined_mkt"),
        col("main_link.brandcode"),
        col("fact_cpa.insid"),
        col("dim_party.insid_aspen"),
        col("geo.provincecode"),
        when(col("org_insid.rsm_code").isNull(), col("org_noinsid.rsm_code")).otherwise(
            col("org_insid.rsm_code")).alias("rsm_code"),
        when(col("org_insid.dsm_code").isNull(), col("org_noinsid.dsm_code")).otherwise(
            col("org_insid.dsm_code")).alias("dsm_code"),
        when(col("org_insid.mr_code").isNull(), col("org_noinsid.mr_code")).otherwise(col("org_insid.mr_code")).alias(
            "mr_code"),
        when(col("org_insid.dsm").isNull(), col("org_noinsid.dsm")).otherwise(col("org_insid.dsm")).alias("dsm"),
        when(col("org_insid.rsm").isNull(), col("org_noinsid.rsm")).otherwise(col("org_insid.rsm")).alias("rsm"),
        when(col("org_insid.mr").isNull(), col("org_noinsid.mr")).otherwise(col("org_insid.mr")).alias("mr"),
        when(col("org_insid.team").isNull(), col("org_noinsid.team")).otherwise(col("org_insid.team")).alias("team"),
        when(col("org_insid.region").isNull(), col("org_noinsid.region")).otherwise(col("org_insid.region")).alias(
            "region"),
        when(col("org_insid.rsd_code").isNull(), col("org_noinsid.rsd_code")).otherwise(
            col("org_insid.rsd_code")).alias("rsd_code"),
        when(col("org_insid.rsd").isNull(), col("org_noinsid.rsd")).otherwise(col("org_insid.rsd")).alias("rsd")
    ).write.csv("s3 target temp_link_dim_main_mkt_02 table path")
