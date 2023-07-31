module "glue_script" {
  source       = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "gitaction-s3-terraform"
  scripts_bucket_location ="cedc_s3_read_data_youqun.py"
  scripts_path ="${path.module}/cedc_s3_read_data_youqun.py"
}

module "glue_job" {
  source             = "../../cedc_terraform_generic_modules/modules/glue"
  job_name           = "cedc-s3-read-s3-data-glue-job-youqun"
  role_name          = "glue_execute_role"
  s_location         = "s3://gitaction-s3-terraform"
  dependencies       = ["cedc_terraform_development/cedc_glue_iam_common"]
}


module "step_function_glue" {
  source                = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name    = "cedc-sfn-workflow-state-machine-mc"
  role_name             = "step_functions_execute_role"  # 请替换为您的角色名称
  definition            = "state_machine_definition_mc.json"  # 请替换为您的状态机定义
  tags                  = {"cedc"}  # 可根据实际情况进行调整
  depends_on            = [module.glue_job]
}
