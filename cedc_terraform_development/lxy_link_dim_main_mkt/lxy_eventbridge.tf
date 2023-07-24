module "aws_cloudwatch_event_rule_xy" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  eventbridgename = "cedc-eventbridge-trigger-lambda-xy"
  # role_arn        = aws_cloudwatch_event_rule.event_rule.arn
  description     = "input sfn name to Trigger Lambda every five minutes"
  schedule_expression = "rate(5 minutes)"  # 每五分钟触发一次
  event_pattern = <<PATTERN
{
  "source": ["my-event-source"],
  "detail-type": ["my-event-type"],
  "detail": {
    "state_machine_name": ["${state_machine_xy.state_machine_name}"]
  }
}
PATTERN
  target {
    arn = aws_lambda_function.my_lambda_function.arn
  }
}
