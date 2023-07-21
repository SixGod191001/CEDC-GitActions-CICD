## CEDC——命名规范

<项目名>-<功能>-<姓名>

EventBridge：cedc-eventbridge-trigger-lambda-yourname

Lambda：cedc-lambda-trigger-sfn-yourname

step Functions：cedc-sfn-workflow-glue-job-yourname

<项目名>-<数据来源>-<功能>-<姓名>

Glue：cedc-s3-read-s3-data-glue-job-yourname	----- 从s3读取数据(source)


注：                    
1)数据来源包含s3/postgre   
2)sfn:stepFunctions缩写             
3)姓名使用英文小写，两字姓名全拼，两字及以上使用后两字全拼                       
eg：张三--zhangsan，李小四--xiaosi


