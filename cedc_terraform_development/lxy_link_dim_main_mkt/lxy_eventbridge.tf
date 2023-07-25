module "aws_cloudwatch_event_rule_xy" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  name            = "cedc-eventbridge-trigger-lambda-xy"
  role_arn        = eventbridge_invoke_lambda_iam_role.arn
  is_enabled      = "enabled"
  schedule_expression = "rate(5 minutes)"  # 每五分钟触发一次
  event_pattern = <<PATTERN
{
  "detail": {
    "state_machine_name": ["${state_machine_xy.state_machine_name}"]
  }
}
PATTERN
  target {
    arn = lambda_to_stepfunctions_iam_role.arn
  }
}
