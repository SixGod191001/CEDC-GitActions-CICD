module "glue_script" {
  source       = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "scriptbucket"
  scripts_name ="cicdgluescript.py"
  scripts_path ="${path.module}/cicdgluescript.py"
}

module "glue_job" {
  source             = "../../cedc_terraform_generic_modules/modules/glue"
  job_name           = "cicd-gitaction-glue-job"
  role_name          = "glue_execute_role"
  worker_number      =  2
  work_type          = "Standard"
  glue_version       = "2.0"
  s3_path_header     = "s3://"
  s3_path_tail       = "/cicdgluescript.py"
  scripts_bucket_name = "scriptbucket"
  dependencies       = ["cedc_terraform_development/cedc_glue_iam_common"]
  depends_on         = [module.glue_script]
  
 }

module "step_function_glue" {
  source                = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name    = "cicd-workflow-state-machine"
  role_name             = "step_functions_execute_role" 
  definition            = file("${path.module}/state_machine_definition.json")
  tags                  = {}  # 可根据实际情况进行调整
  depends_on            = [module.glue_job]
}
