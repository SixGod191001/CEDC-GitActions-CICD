resource "aws_cloudwatch_event_rule" "event_rule" {
  name                  = var.event_rule_name
  schedule_expression   =var.schedule_expression_details
  event_pattern         =var.event_pattern_details
  is_enabled            =var.event_enabled
}

resource "aws_cloudwatch_event_target" "event_rule_target" {
  rule                  = aws_cloudwatch_event_rule.event_rule.name
  depends_on            = [var.arn_details]
  arn                   =var.arn_details
}

resource "aws_lambda_permission" "allow_cloudwatch_to_trigger_event_rules" {
  count                  = var.function_details_name == null ? 0 : 1
  action                 = "lambda:InvokeFunction"
  function_name          = var.function_details_name
  principal              = "events.amazonaws.com"
  source_arn             =  aws_cloudwatch_event_rule.event_rule.arn
}