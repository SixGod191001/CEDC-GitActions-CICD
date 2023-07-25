import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when

def temp_link_dim_main_mkt_02():

    # 创建对象
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    # spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)

    # 读取 s3 source
    temp_link_dim_main_mkt_01 = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse": True,
        }
    )

    fact_cpa = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    dim_party = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    dim_geography = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    temp_org_insid = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    temp_org_noinsid = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )
    # toDF
    temp_link_dim_main_mkt_01_df = temp_link_dim_main_mkt_01.toDF()
    fact_cpa_df = fact_cpa.toDF()
    dim_party_df = dim_party.toDF()
    dim_geography_df = dim_geography.toDF()
    temp_org_noinsid_df = temp_org_noinsid.toDF()
    temp_org_insid_df = temp_org_insid.toDF()

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
    writer_df = joined_df.select(
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
    )

    # 写入 s3 target
    temp_link_dim_main_mkt_02 = glueContext.write_dynamic_frame.from_options(
        frame=writer_df,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []  # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()
