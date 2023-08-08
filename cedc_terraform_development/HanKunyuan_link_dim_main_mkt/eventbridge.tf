# create eventbridge rule
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"                                   # trigger every minute
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbirdge"]    # depends on the created IAM
}

output "event_rule_arn_by_ssm" {
  value       = module.cloudwatch_event_rule.event_rule_arn_by_ssm
  description = "output ARN of the created EventBridge rule by SSM"
}

output "event_rule_name" {
  value       = module.cloudwatch_event_rule.event_rule_name
  description = "output NAME of the EventBridge rule created in the module"
}

# target lambda adds permissions that can be operated by eventbridge
module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "Test"
  execution_arn               = module.cloudwatch_event_rule.event_rule_arn_by_ssm       # ARN of the EventBridge
  depends_on                  = [module.cloudwatch_event_rule]                           # This module depends on eventbridge already being created
}

# add eventbridge rule target
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = module.cloudwatch_event_rule.event_rule_name
  target_id                   = "eventbridge_target_for_lambda"
  lambda_function_name        = "Test"                                                    # NAME of the target lambda to get arn
  depends_on                  = [module.lambda_add_permission]                            # This module depends on lambda added permission
}


