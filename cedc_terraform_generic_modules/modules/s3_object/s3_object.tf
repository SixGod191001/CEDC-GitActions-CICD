data "aws_ssm_parameter" "ssm_param" {
  name = var.scripts_bucket_name
}


resource "aws_s3_bucket_object" "glue_script" {
  bucket = data.aws_ssm_parameter.ssm_param.value
  key    = var.scripts_name
  source = var.scripts_path
}
