## CEDC——命名规范

<项目名>-<功能>-<user>-<地区/aws区域>-<环境>

EventBridge：cedc-event-schedule-trigger-lambda-user-ap-northeast-1-dev

Lambda：cedc-lambda-trigger-sfn-user-ap-northeast-1-dev

step Functions：cedc-sm-workflow-glue-job-pyspark-user-ap-northeast-1-dev

Glue：

​		cedc-read-s3-data-user-glue-job--ap-northeast-1-dev	----- 从s3读取数据(source)

​		cedc-data-processing-user-glue-job--ap-northeast-1-dev   ----数据处理(workflow)

​		cedc-data-to-s3-processing-user-glue-job--ap-northeast-1-dev	-----处理后的数据传到s3(target)



可更改：user

