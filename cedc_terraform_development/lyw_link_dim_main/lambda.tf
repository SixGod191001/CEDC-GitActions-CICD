resource "aws_lambda_fucntion" "lambda_vic" {
  lambda_name          = "lambda_vic"
  source               = "../../cedc_terraform_generic_modules/modules/lambda"
  lambda_role_arn      = lambda_to_stepfunctions_execute_role000
  lambda_handler       = "main.handler"
  lambda_runtime       = "python3.9"
  source_code_hash     = filebase64sha256("lambda_definition.json")
}

