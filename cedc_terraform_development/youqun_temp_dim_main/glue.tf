module "glue_script" {
  source       = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "gitaction-s3-terraform"
  scripts_bucket_location =""
  scripts_path ="../../cedc_terraform_development/youqun_temp_dim_main/cedc_s3_read_data_youqun.py"
}

module "glue_job" {
  source             = "../../cedc_terraform_generic_modules/modules/glue"
  job_name           = "cedc-s3-read-s3-data-glue-job-youqun"
  role_name          = "glue_execute_role1"
  s_location         = "s3://gitaction-s3-terraform"
  dependencies       = ["cedc_terraform_development/cedc_glue_iam_common"]
}
