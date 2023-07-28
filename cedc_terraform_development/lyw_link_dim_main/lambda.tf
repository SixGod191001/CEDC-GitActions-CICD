module "lambda" {
  source        = "../../cedc_terraform_generic_modules/modules/lambda"
  role          = lambda_to_stepfunctions_execute_role000
  handler       = "main.handler"
  runtime       = "python3.9"
  environment {
    variables = jsondecode(file("${path.module}/lambda_definition.json"))["environment"]["variables"]
  }
  tags = jsondecode(file("${path.module}/lambda_definition.json"))["tags"]
 
}
  
