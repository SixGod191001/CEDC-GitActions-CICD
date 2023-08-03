module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbirdge"]
}

 output "eventbridge_name" {
    value = cloudwatch_event_rule.event_rule_name
}

module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "Test"
  execution_arn               = "arn:aws:events:ap-northeast-1:213903534337:rule/cedc-eventbridge-trigger-lambda"   #调用event bridge的arn
  depends_on                  = [module.cloudwatch_event_rule]
}


module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  target_id                   = "Test"
  # arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"
  arn_details                 = module.cloudwatch_event_rule.eventbridge_name
  depends_on                  = [module.lambda_add_permission]
}

