module "glue_script" {
  source               = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name  = "scriptbucket"
  scripts_name         ="cicd_glue_script.py"
  scripts_path         ="${path.module}/cicd_glue_script.py"
}

module "glue_job" {
  source             = "../../cedc_terraform_generic_modules/modules/glue"
  job_name           = "cicd_gitaction_glue_job"
  role_name          = "glue_execute_role"
  worker_number      =  2
  work_type          = "Standard"
  glue_version       = "2.0"
  s3_path_header     = "s3://"
  s3_path_tail       = "/cicd_glue_script.py"
  scripts_bucket_name = "scriptbucket"
  dependencies       = ["cedc_terraform_development/cedc_glue_iam_common"]
  depends_on         = [module.glue_script]  
 }

module "step_function_glue" {
  source                = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name    = "cicd_workflow_state_machine"
  role_name             = "step_functions_execute_role" 
  definition            = file("${path.module}/state_machine_definition.json")
  tags                  = {}  # 可根据实际情况进行调整
  dependencies          = ["cedc_terraform_development/cedc_step_functions_iam_common"]
  depends_on            = [module.glue_job]
}

module "lambda_script" {
  source               = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name  = "scriptbucket"
  scripts_name         = "cicd_lambda_scprit.zip"
  scripts_path         = "${path.module}/cicd_lambda_scprit.zip"
  depends_on           = [module.step_function_glue]
}

module "lambda" {
  source               = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name        = "cicd_workflow_lambda"
  role_name            = "lambda_execute_role"
  handler              = "lambda_function.lambda_handler"
  runtime              = "python3.9"
  scripts_bucket_name  = "scriptbucket"
  s3_key               = "cicd_lambda_scprit.zip"
  dependencies         = ["cedc_terraform_development/cedc_lambda_iam_common"]
  depends_on           = [module.lambda_script]
}

# "depends_on" of each module may needs to be appropriately adjusted 
# create eventbridge rule
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cicd_eventbridge_trigger_lambda"
  schedule_expression_details = "rate(14 minutes)"                                              # trigger every minute
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbridge_iam_common"]    # depends on the created IAM
  depends_on                  = [module.lambda]                                               # This module depends on lambda already being created
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
  lambda_function_name        = "cicd_workflow_lambda"                                            # NAME of the target lambda (need to change)
  execution_arn               = module.cloudwatch_event_rule.event_rule_arn       # ARN of the EventBridge
  depends_on                  = [module.cloudwatch_event_rule]                    # This module depends on eventbridge and lambda already being created
}

# add eventbridge rule target
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = module.cloudwatch_event_rule.event_rule_name
  target_id                   = "eventbridge_target_for_lambda"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:cicd_workflow_lambda"     # ARN of the target lambda (need to change)
  depends_on                  = [module.lambda_add_permission]                                 # This module depends on eventbridge being created and lambda being added permissions
}
    
    
