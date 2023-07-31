module "aws_cloudwatch_event_rule" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  name            = "cedc-eventbridge-trigger-lambda"

  role_name        = "eventbridge_invoke_lambda_execute_role"

  event_rule_name = "schedule_rate"
  schedule_expression_details = "rate(1 hour)"  # 每一小时触发一次
}

  

