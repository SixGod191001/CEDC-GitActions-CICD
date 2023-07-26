resource "aws_lambda_fucntion" "lambda_name" {
  name        = var.lambda_name
  role_arn    = var.lambda_role_arn
  handler     = var.lambda_handler
  runtime     = var.lambda_runtime
  source_code = var.source_code_hash
}
