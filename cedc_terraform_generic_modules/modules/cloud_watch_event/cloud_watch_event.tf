data "aws_iam_role" "cloudwatch_event_role" {
  name = var.role_name
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                  = var.event_rule_name
  schedule_expression   =var.schedule_expression_details
  event_pattern         =var.event_pattern_details
  is_enabled            =var.event_enabled
  role_arn   = data.aws_iam_role.cloudwatch_event_role.arn
}

resource "aws_cloudwatch_event_target" "event_rule_target" {
  rule                  = aws_cloudwatch_event_rule.event_rule.name
  depends_on            = [var.arn_details]
  arn                   =var.arn_details
}
