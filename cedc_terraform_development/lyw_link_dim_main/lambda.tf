module "aws_lambda" {
  source        = "../../cedc-terraform-generic-modules/modules/lambda"
  function_name = "cedc-lambda-trigger-sfn-lyw"
  role          = lambda_to_stepfunctions_execute_role0vic
  handler       = "main.handler"
  runtime       = "python3.8"

}
