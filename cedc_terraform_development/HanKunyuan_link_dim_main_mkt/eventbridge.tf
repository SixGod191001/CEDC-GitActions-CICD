module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  event_rule_name             ="cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(5 minutes)"
  arn_details                 ="arn:aws:lambda:ap-northeast-1:213903534337:function:Test_eb"
  dependencies                = ["cedc_terraform_development/cedc_eventbirdge"]
}

