from pyspark.context import SparkContext
from awsglue.context import GlueContext

# 创建 SparkContext 和 GlueContext
sc = SparkContext()
glueContext = GlueContext(sc)

# 从 S3 读取数据
input_path = "s3source路径"

data_frame = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    format="csv",
    connection_options={"paths": [input_path]},
    transformation_ctx="data_frame"
)
# sql 逻辑
# 输出结果（例如保存到 S3）
output_path = "s3target路径"
glueContext.write_dynamic_frame.from_options(data_frame, connection_type="s3", connection_options={"path": output_path})
