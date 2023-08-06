data "aws_iam_role" "lambda_function_role" {
  name        = var.role_name
}

data "aws_ssm_parameter" "ssm_param" {
 name          = var.scripts_bucket_name
}

resource "aws_lambda_function" "lambda_rule" {
  function_name   = var.function_name
  handler         = var.handler
  runtime         = var.runtime
  role            = data.aws_iam_role.lambda_function_role.arn
  s3_bucket       = data.aws_ssm_parameter.ssm_param.value
  s3_key          = var.s3_key
}
