data "aws_iam_role" "glue_role" {
  name = var.role_name
}

data "aws_ssm_parameter" "ssm_param" {
 name  = var.scripts_bucket_name
}

resource "aws_glue_job" "glue_job" {
  name              = var.job_name
  role_arn          = data.aws_iam_role.glue_role.arn
  number_of_workers = var.worker_number
  worker_type       = var.work_type
  glue_version      = var.glue_version
  
 
command {
    script_location = "s3://${data.aws_ssm_parameter.ssm_param.value}${var.s3_key}"
 }
}
