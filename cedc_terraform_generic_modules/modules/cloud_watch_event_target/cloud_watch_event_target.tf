data "aws_lambda_function" "lambda_function" { 
  function_name    = var. lambda_function_name
}

resource "aws_cloudwatch_event_target" "event_rule_target" {
  rule                = var.event_rule_name
  target_id           = var.target_id
  target_arn          = data.aws_lambda_function.lambda_function.arn
}
