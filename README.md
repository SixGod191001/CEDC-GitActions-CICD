# CEDC-GitActions-CICD
This is repo to use git actions with terraform to deploy resources to aws

![](https://github.com/SixGod191001/CEDC-GitActions-CICD/blob/dev/GithubActions.drawio.png)


1. https://catalog.workshops.aws/stepfunctions/en-US/introduction
Basic:
   - task state
   - run job
   - callback with task token
   - AWS SDK Service integrations
   - Choice and Map State
   - Parallel State
Development:
   - Error Handling
   - Manage State Machines with infrastructure as code
   - Cloud9
   - AWS CDK
   - AWS SAM
   - Terraform
Operation:
   - Metrics
   - Logs
   - Traces
Usecase:
   - Large-Scale Parallelization with Distributed Map
   - Large-Scale Parallelization with Distributed Map

2. GitActions workflow
   - Feature --> DEV  (PR/Push)
   - DEV --> approve --> QA (PR/Push)
   - QA --> approve --> Release(tag)
   
   condition: not all actions will trigger the workflow (include *.tf, *.py etc, exclude README.md etc)
   manual runbook:
     - input variables: 
       - repository
       - branch
       - ENV (github ENV: DEV,QA,PROD)
	   - xxx

3. Glue
   - Pyspark Operator
   - Common Function Wrapper
   - Folder Structure
     - GluePysparkWorkspace
	   - commons
	     - init.py
		 - secret_manager_handler.py
		 - ...
	   - Jb_<name>
	     - xxx.py

4. Lambda
   Execute Step Functions
    - option1: call without parameters
	- option2: call with parameters


5. Terraform
   - Event Bridge
   - Lambda
   - Step Functions
   - Glue
   - DynamoDB Table
   - Execute Role (Lambda Execute Role, Step Functions Execute Role, Glue Execute Role)
   
   
.
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── modules/
│   ├── module1/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── module2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── main.tfvars
│   ├── prod/
│   │   ├── main.tfvars
├── .terraform/
├── terraform.tfstate
├── terraform.tfstate.backup
├── .gitignore
├── README.md


6. Step Functions
call glue


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

 ## CICD Workflow  
 ```
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
      ┌────────────────┐    Pull Request
      │   QA Env       │◀── With Reviewer
      │ (Branch: main) │
      │    (Jacky)     │
      └────────────────┘
             │
             ▼
      ┌────────────────┐    Release Request
      │   Prod Env     │◀── With Approval
      │ (Branch: tag)  │
      │     (Cui)      │
      └────────────────┘
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