data "aws_iam_role" "lambda_function_role" {
  name = var.role_name
}

resource "aws_lambda_function" "lambda_rule" {
  function_name = var.function_name
  handler     = var.handler
  runtime     = var.runtime
  role   = data.aws_iam_role.lambda_function_role.arn
  s3_bucket = var.s3_bucket
  s3_key = var.s3_key
 
}
