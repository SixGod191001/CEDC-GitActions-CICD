![CEDC](https://gitee.com/SixGod2019/shared-info/raw/master/github_images/images/cedc-logo.png)

## Backgroud
This project is aiming to build a whole cloud based CICD ETL process. Include below Parts:

1. Cloud Service
   - EventBrige
   - Lambda
   - Step Function
   - Glue
2. Terraform 
3. GitAction CICD
4. Glue ETL Common Solution
5. Multi-account architecture

## Project Name
<font color=red>**C**</font>loud base <font color=red>**E**</font>TL <font color=red>**D**</font>evOps process of <font color=red>**C**</font>ommunity = <font color=red>**CEDC**</font> **GITACTION**</font> **CICD**

## Project Directory
- [cedc_terraform_generic_modules](https://github.com/SixGod191001/CEDC-GitActions-CICD/tree/main/cedc_terraform_generic_modules)
- [cedc_terraform_development](https://github.com/SixGod191001/CEDC-GitActions-CICD/tree/main/cedc_terraform_development)
  
## Project Wiki
[Project Wiki](https://github.com/SixGod191001/CEDC-GitActions-CICD/wiki)
  - [Home](https://github.com/SixGod191001/CEDC-GitActions-CICD/wiki)
  - [Q&A](https://github.com/SixGod191001/CEDC/wiki/QA---%E5%B7%B2%E7%9F%A5%E9%97%AE%E9%A2%98-&-%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88)
    
## Project Sprint
[Sprint](https://github.com/users/SixGod191001/projects/3)

## Architecture

## CICD Diagram
![](https://github.com/SixGod191001/CEDC-GitActions-CICD/blob/main/documents/GithubActions.drawio.png)

## Business Diagram
![](https://github.com/SixGod191001/CEDC-GitActions-CICD/blob/main/documents/Phase2.drawio.png)

## Release Diagram
![](https://github.com/SixGod191001/CEDC-GitActions-CICD/blob/main/documents/github_release_workflow.drawio.png)


## Operation process
## WORKSHOP
1. Step Function  https://catalog.workshops.aws/stepfunctions/en-US/introduction
2. Sagemaker      https://catalog.us-east-1.prod.workshops.aws/workshops/63069e26-921c-4ce1-9cc7-dd882ff62575/en-US
3. DataBrew       https://catalog.us-east-1.prod.workshops.aws/workshops/6532bf37-3ad2-4844-bd26-d775a31ce1fa/en-US

## GitActions workflow
   - Feature --> DEV  (PR/Push)
   - DEV --> approve --> Release(tag) (PR/Push) tag是备份，不触发发布流程
   - Release(tag) --> approve --> Main(PROD)

   condition: not all actions will trigger the workflow (include *.tf, *.py etc, exclude README.md etc)
   manual runbook:
     - input variables: 
       - repository
       - branch
       - ENV (github ENV: DEV,QA,PROD)
	   - xxx
## GitActions workflow Chart

      ┌────────────────┐
      │   Feature Env  │
      │     (Branch)   │
      └────────────────┘
             │
             ▼
      ┌────────────────┐ ◀── Pull Request
      │   Dev Env      │
      │  (Branch: dev) │
      │ (aws:cedc_glue)│
      └────────────────┘
             │
             ▼
      ┌────────────────┐    Pull Request --TAG
      │   Relaease Env       │◀── With Reviewer
      │ (Branch: release) │
      │    (Cui)     │
      └────────────────┘
             │
             ▼
      ┌────────────────┐    Release Request
      │   Prod Env     │◀── With Approval
      │ (Branch: main)  │
      │     (Jakey)      │
      └────────────────┘
   
   ## Github CICD integration in AWS

To integrate Github CICD with AWS, follow these steps:

a. Create an OpenID Connect provider with the following configuration:
```
   - URL: `token.actions.githubusercontent.com`
   - Audience: `sts.amazonaws.com`
```
b. Create an IAM role with the following trust policy:
```
   {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::875120157787:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:SixGod191001/CEDC-GitActions-CICD:*"
        }
      }
    }
  ]
}
```
This policy allows the role to be assumed by any user authenticated by the OpenID Connect provider for the repository `SixGod191001/CEDC-GitActions-CICD`.

c. Create two policies with the following permissions:
- `github-action-service-terroform-tfstates-s3-access`: Allows S3 `PutObject`, `GetObject`, and `ListBucket` operations for the `github-actions-terraform-tfstates` S3 bucket.
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::github-actions-terraform-tfstates/*",
        "arn:aws:s3:::github-actions-terraform-tfstates"
      ]
    }
  ]
}
````

- `github-actions-terraform-allow-service`: Allows access to AWS resources required by Github Actions, such as `states:`, `secretsmanager:`, and `ssm:`. The actual resources this policy grants access to should be specified based on your use case.
````
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Statement1",
      "Effect": "Allow",
      "Action": [
        "states:",
        "secretsmanager:",
        "ssm:"
      ],
      "Resource": ""
    }
  ]
}
````

d. Create an S3 bucket to store the state file.



 ```
## CEDC——命名规范
```
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


```

