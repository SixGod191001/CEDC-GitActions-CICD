module "aws_cloudwatch_event_rule" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  name            = "cedc-eventbridge-trigger-lambda"

  role_arn        = eventbridge_invoke_lambda_iam_role.arn

  event_rule_name = "schedule_rate"
  schedule_expression_details = "rate(1 hour)"  # 每五分钟触发一次
  

