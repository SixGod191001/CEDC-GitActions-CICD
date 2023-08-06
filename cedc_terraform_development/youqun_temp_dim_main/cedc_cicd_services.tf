module "glue_script" {
  source       = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "scriptbucket"
  scripts_name ="cicd-glue-script.py"
  scripts_path ="${path.module}/cicd-glue-script.py"
}

module "glue_job" {
  source             = "../../cedc_terraform_generic_modules/modules/glue"
  job_name           = "cicd-gitaction-glue-job"
  role_name          = "glue_execute_role"
  worker_number      =  2
  work_type          = "Standard"
  glue_version       = "2.0"
  s3_path_header     = "s3://"
  s3_path_tail       = "/cicd-glue-script.py"
  scripts_bucket_name = "scriptbucket"
  dependencies       = ["cedc_terraform_development/cedc_glue_iam_common"]
  depends_on         = [module.glue_script]  
 }

module "state_machine" {
  source            = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = "cicd-workflow-state-machine"
  role_name          = "step_functions_execute_role"
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
  dependencies       = ["cedc_terraform_development/cedc_step_functions_iam_common"]
}

module "step_function_glue" {
  source                = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name    = "cicd-workflow-state-machine"
  role_name             = "step_functions_execute_role" 
  definition            = file("${path.module}/state_machine_definition.json")
  tags                  = {}  # 可根据实际情况进行调整
  depends_on            = [module.glue_job]
}



module "lambda_script" {
  source = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "scriptbucket"
  scripts_name  = "cicd-lambda-scprit.zip"
  scripts_path = "${path.module}/cicd-lambda-scprit.zip"
}

module "lambdavic" {
  source = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name = "cicd-workflow-lambda"
  role_name = "lambda_execute_role"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  s3_bucket = "gitaction-s3-terraform"
  s3_key = "cicd-lambda-scprit.zip"
  dependencies = ["cedc_terraform_development/lyw_cedc_lambda_iam_common","state_machine"]
}

# "depends_on" of each module may needs to be appropriately adjusted 
# create eventbridge rule
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cicd-eventbridge-trigger-lambda"
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
  lambda_function_name        = "cicd-workflow-lambda"                                            # NAME of the target lambda (need to change)
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
    
    
