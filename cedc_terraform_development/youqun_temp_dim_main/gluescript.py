from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.transforms import *

# 创建 SparkContext
sc = SparkContext()
glueContext = GlueContext(sc)

# 读取 S3 数据源
source_path = "s3://cicddevraw/source/dim_brand_test.csv"
data_frame = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    format="csv",
    connection_options={
        "paths": [source_path],
    },
    transformation_ctx="data_frame"
)

# 处理数据
processed_data_frame = data_frame

# 保存至目标 S3 存储桶
target_path = "s3://cicddevtarget/target/"
glueContext.write_dynamic_frame.from_options(
    frame = processed_data_frame,
    connection_type = "s3",
    connection_options = {"path": target_path},
    format = "csv"
)
