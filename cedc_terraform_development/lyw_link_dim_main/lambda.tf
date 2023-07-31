module "lambdavic" {
  source       = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name   =  "lyw_labdavic"
  role_name = "lambda_to_stepfunctions_execute_role0001"
  handler       = "main.handler"
  runtime       = "python3.8"
  s3_bucket     = "gitaction-s3-terraform"
  s3_key        = "my-lambda-function.zip"
 }

