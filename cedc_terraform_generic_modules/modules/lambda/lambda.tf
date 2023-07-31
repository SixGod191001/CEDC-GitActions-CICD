resource "aws_lambda_function" "lambda_name" {
  name        = var.name
  role_arn    = var.role_arn
  handler     = var.handler
  runtime     = var.runtime
  source_code = var.source_code_hash
}
