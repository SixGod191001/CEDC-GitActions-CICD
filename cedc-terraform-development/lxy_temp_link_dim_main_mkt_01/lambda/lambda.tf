module "aws_lambda" {
  source        = "../../cedc-terraform-generic-modules/modules/lambda"
  function_name = "cedc-lambda-trigger-sfn-xy"
  role          = aws_iam_role.lambda_role.arn
  handler       = "main.handler"
  runtime       = "python3.8"
}