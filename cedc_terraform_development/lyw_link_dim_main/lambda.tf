module "lambda_script" {
  source = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "gitaction-s3-terraform"
  scripts_name  = "my-lambda-function.zip"
  scripts_path = "${path.module}/my-lambda-function.zip"
  }
module "lambdavic" {
  source       = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name   =  "lyw_labdavic"
  role_name = "lambda_to_stepfunctions_execute_role0002"
  handler       = "main.handler"
  runtime       = "python3.9"
  s3_bucket     = "gitaction-s3-terraform"
  s3_key        = "my-lambda-function.zip"
  dependencies  = ["cedc_terraform_development/lyw_cedc_lambda_iam_common"]
 }

