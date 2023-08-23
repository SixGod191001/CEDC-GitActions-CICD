module "create_glue_catalog_table" {
  source                    = "../../cedc_terraform_generic_modules/modules/glue_catalog_table"
  table_strctr_file_path    = "${path.module}"
  glue_catalog_table_list   = "*_strctr.json"
  datafile_bucket_name      = "scriptbucket"
  s3_key                    = "databrew_workshop/datafiles"
  #depends_on                = [module.create_glue_database]
}

module "glue_script" {
  source               = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name  = "scriptbucket"
  scripts_name         ="cicd_glue_script.py"
  scripts_path         ="${path.module}/cicd_glue_script.py"
  depends_on           = [module.create_glue_catalog_table]
}

module "glue_job" {
  source              = "../../cedc_terraform_generic_modules/modules/glue"
  job_name            = "cicd_gitaction_glue_job"
  s3_key              = "/cicd_glue_script.py"
  depends_on          = [module.glue_script]
 }

module "step_function_glue" {
  source                = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name    = "cicd_workflow_state_machine"
  definition            = file("${path.module}/state_machine_definition.json")
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
  s3_key               = "cicd_lambda_scprit.zip"
  depends_on           = [module.lambda_script]
}

# create eventbridge rule
module "cloudwatch_event_rule" {
  source                       = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name              = "cicd-eventbridge-trigger-lambda"
  schedule_expression_details  = "rate(32 minutes)"                                              # trigger every minute
  depends_on                   = [module.lambda]  
}

# target lambda adds permissions that can be operated by eventbridge
module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "cicd_workflow_lambda"
  event_rule_name             = "cicd-eventbridge-trigger-lambda"
  depends_on                  = [module.cloudwatch_event_rule]                           # This module depends on eventbridge already being created
}

# add eventbridge rule target
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = "cicd-eventbridge-trigger-lambda"
  target_id                   = "eventbridge_target_for_lambda"
  lambda_function_name        = "cicd_workflow_lambda"                                    # NAME of the target lambda to get arn
  depends_on                  = [module.lambda_add_permission]                            # This module depends on lambda added permission
}
