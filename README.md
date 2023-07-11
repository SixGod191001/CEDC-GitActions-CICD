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

