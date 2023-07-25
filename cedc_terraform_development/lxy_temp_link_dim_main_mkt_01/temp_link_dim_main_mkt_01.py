import json
from pyspark.context import SparkContext
from pyspark.sql import SparkSession

def temp_link_dim_main_mkt_01():
    # 创建对象
    args = getResolvedOptions(sys.argv, ["JOB_NAME"])
    sc = SparkContext()
    glueContext = GlueContext(sc)
    # spark = glueContext.spark_session
    job = Job(glueContext)
    job.init(args["JOB_NAME"], args)

    # 读取 s3 source
    fact_cpa = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "paths": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse": True,
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

    temp_ym = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    link_dim_ims = glueContext.create_dynamic_frame.from_options(
        format_options={"withHeader": True, "separator": ","},
        connection_type="s3",
        format="csv",
        connection_options={
            "path": ["s3://source-demo-test/demo-table-1.csv"]
            # "recurse":True  # 分区写入,True 表示glue会按照一个文件写入
        }
    )

    # toDF

    fact_cpa_df = fact_cpa.toDF()
    dim_geography_df = dim_geography.toDF()
    temp_ym_df = temp_ym.toDF()
    link_dim_ims_df = link_dim_ims.toDF()

    # where
    cap_city_join = fact_cpa_df.join(dim_geography_df,(fact_cpa_df['citycode'] == dim_geography_df['citycode']),how='left') \
        .selectExpr('citycode','ims_citycode','1 as joinkey')
    cap_city_where = cap_city_join.where(cap_city_where['ims_citycode'].isNotNull()) \
        .dropDuplicates()

    main_dim = cap_city_where.join(temp_ym_df,(cap_city['joinkey'] == temp_ym_df['joinkey']),how='left') \
        .selectExpr('ym','citycode','ims_citycode')
    # link_dim_ims_df = sk.read.csv("s3 source link_dim_ims path",sep=',',header=True)
    mkt = link_dim_ims_df.selectExpr('ym','defined_mkt','brand_code as brandcode') \
        .union(fact_cpa_df.selectExpr('ym','defined_mkt','brandcode'))
    writer_df = main_dim.join(mkt,on='ym',how='left').selectExpr('ym','citycode','ims_citycode','defined_mkt','brandcode')
        # .write.csv("s3 temp_link_dim_main_mkt_01 path")

    # toDynamicFrame

    temp_link_dim_main_mkt_01_DY = DynamicFrame.fromDF(writer_df, glueContext, "temp_link_dim_main_mkt_01_DY")

    # 写入 s3 target
    temp_link_dim_main_mkt_01 = glueContext.write_dynamic_frame.from_options(
        frame=temp_link_dim_main_mkt_01_DY,
        connection_type="s3",
        format="csv",
        connection_options={
            "path": "s3://target-demo-test/temp_ym/",
            "partitionKeys": []  # 禁止分区写入，默认是分区写入
        }
    )

    job.commit()