import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)


def temp_org_noinsid():
    # 创建 对象
    sk = SparkSession.builder \
        .appName("Read data from S3 to data processing") \
        .getOrCreate()

    # 读取 s3 source 文件
    temp_ym_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    dim_report_line_df = sk.read.csv("s3 source fact_ims_city path",sep=',',header=True)
    # left join  1 = 1 全表join
    join_df = temp_ym_df.join(dim_report_line_df, 1 == 1, how="left")
    # 查找想要字段
    join_df.selectExpr('ym','insid','brandcode','citycode','provincecode','rsm_code', 'dsm_code', 'mr_code', 'dsm', 'rsm','mr','team','region','rsd_code','rsd') \
        .dropDuplicates \
        .write \
        .csv("s3 target temp_org_noinsid table path")
