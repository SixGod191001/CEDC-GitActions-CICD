module "lambda" {
  source        = "../../cedc_terraform_generic_modules/modules/lambda"
  role          = lambda_to_stepfunctions_execute_role000
  handler       = "main.handler"
  runtime       = "python3.8"
  filename      = "lambda_definition.json"
  source_code_hash = filebase64sha256("lambda_definition.json")

}
