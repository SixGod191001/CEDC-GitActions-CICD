module "lambdavic" {
  role         = "lambdavic"
  source       = "../../cedc_terraform_generic_modules/modules/lambda"
  role_arn     = "lambda_to_stepfunctions_execute_role0001"
  handler      = "main.handler"
  runtime      = "python3.9"
 }

