# create eventbridge rule
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbirdge"]
}

output "event_rule_arn" {
  value       = module.cloudwatch_event_rule.event_rule_arn
  description = "output ARN of the EventBridge rule created in the module"
}

# target lambda adds permissions that can be operated by eventbridge
module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "Test"
  execution_arn               = module.cloudwatch_event_rule.event_rule_arn       # ARN of the EventBridge
  depends_on                  = [module.cloudwatch_event_rule]                    # This module depends on eventbridge already being created
}

# add eventbridge target
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  target_id                   = "Test"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"     # ARN of the lambda
  depends_on                  = [module.lambda_add_permission]                                 # This module depends on lambda added permission
}

