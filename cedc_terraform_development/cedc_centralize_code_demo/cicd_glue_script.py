from pyspark.context import SparkContext
from awsglue.context import GlueContext

# 创建 SparkContext
sc = SparkContext()
glueContext = GlueContext(sc)

# 从 AWS Glue 数据目录（catalog）中读取表数据
database_name = "default"
table_name = "fact_ims_chpa"
data_frame = glueContext.create_dynamic_frame.from_catalog(
    database=database_name,
    table_name=table_name
)

# 处理数据
processed_data_frame = data_frame

# 保存至目标 S3 存储桶
target_path = "s3://cicddevtarget/target/"
glueContext.write_dynamic_frame.from_options(
    frame=processed_data_frame,
    connection_type="s3",
    connection_options={"path": target_path},
    format="csv"
)
