/*
data "aws_cloudwatch_event_rule" "event_rule" {
  name = var.event_rule_name
}
*/

resource "aws_lambda_permission" "lambda_permission" {
  statement_id   = var.permission_statement_id
  action         = "lambda:InvokeFunction"
  function_name  = var.lambda_function_name
  principal      = "events.amazonaws.com"
# source_arn     = data.aws_cloudwatch_event_rule.event_rule.arn
  source_arn     = var.execution_arn
}
