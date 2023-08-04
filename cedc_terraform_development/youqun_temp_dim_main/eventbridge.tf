# "depends_on" of each module may needs to be appropriately adjusted 
# create eventbridge rule
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"                                              # trigger every minute
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbridge_iam_common"]    # depends on the created IAM
# depends_on                  = [module.lambda]                                               # This module depends on lambda already being created
}

output "event_rule_arn" {
  value       = module.cloudwatch_event_rule.event_rule_arn
  description = "output ARN of the EventBridge rule created in the module"
}

output "event_rule_name" {
  value       = module.cloudwatch_event_rule.event_rule_name
  description = "output NAME of the EventBridge rule created in the module"
}

# target lambda adds permissions that can be operated by eventbridge
module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "Test"                                            # NAME of the target lambda (need to change)
  execution_arn               = module.cloudwatch_event_rule.event_rule_arn       # ARN of the EventBridge
  depends_on                  = [module.cloudwatch_event_rule]                    # This module depends on eventbridge and lambda already being created
}

# add eventbridge rule target
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = module.cloudwatch_event_rule.event_rule_name
  target_id                   = "eventbridge_target_for_lambda"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"     # ARN of the target lambda (need to change)
  depends_on                  = [module.lambda_add_permission]                                 # This module depends on eventbridge being created and lambda being added permissions
}
