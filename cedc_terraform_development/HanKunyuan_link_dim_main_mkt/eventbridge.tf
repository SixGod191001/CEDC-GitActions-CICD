module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbirdge"]
}


module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = event_rule_name
  target_id                   = "Test"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"
  depends_on                  = [module.cloudwatch_event_rule]
}

