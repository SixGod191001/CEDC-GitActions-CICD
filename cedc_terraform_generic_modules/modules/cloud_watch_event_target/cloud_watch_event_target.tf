resource "aws_cloudwatch_event_target" "event_rule_target" {
  rule         = aws_cloudwatch_event_rule.event_rule.name
  target_id    = var.target_id
  arn          = var.arn_details
  dependencies =["cedc_terraform_generic_modules/modules/cloud_watch_event"]
}
