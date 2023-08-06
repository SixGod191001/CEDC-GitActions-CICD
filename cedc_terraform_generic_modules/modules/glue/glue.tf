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
  s3_bucket         = data.aws_ssm_parameter.ssm_param.value
 
command {
    script_location = "${var.s3_path_header}${s3_bucket}${var.s3_path_tail}"  
 }
}
