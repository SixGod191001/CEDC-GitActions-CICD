import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

# 获取命令行参数
args = getResolvedOptions(sys.argv, ['cedc-s3-read-s3-data-glue-job-youqun1'])

# 创建 SparkContext 和 GlueContext
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session

# 初始化 Glue 作业
job = Job(glueContext)
job.init(args['cedc-s3-read-s3-data-glue-job-youqun1'], args)

# 定义源和目标数据目录
source_bucket = 'cicddevraw'
source_key = 'source/dim_brand.py'
target_bucket = 'cicddevtarget'
target_key = 'cedc_temp_dim_mainyouqun.py'

# 读取源表数据
source_table = spark.read.format("parquet").load(f"s3://{source_bucket}/{source_key}")

# 将数据写入目标表
source_table.write.format("parquet").mode("overwrite").save(f"s3://{target_bucket}/{target_key}")

# 结束 Glue 作业
job.commit()



