resource "aws_lambda_fucntion" "lambda_vic" {
  name          ="lambda_vic"
  source        = "../../cedc_terraform_generic_modules/modules/lambda"
  role_arn      = lambda_to_stepfunctions_execute_role000
  handler       = "main.handler"
  runtime       = "python3.9"
  source_code   =filebase64sha256("lambda_definition.json")
}
