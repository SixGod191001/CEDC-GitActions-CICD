resource "aws_lambda_function" "lambdavic" {
  lambda_name          = "lambdavic"
  source               = "../../cedc_terraform_generic_modules/modules/lambda"
  lambda_role_arn      = "lambda_to_stepfunctions_execute_role0001"
  lambda_handler       = "main.handler"
  lambda_runtime       = "python3.9"
  source_code_hash     = filebase64sha256("lambda_definition.json")
}

