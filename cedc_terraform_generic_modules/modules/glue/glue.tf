resource "aws_glue_job" "glue_job" {
  name     = var.job_name
  role_arn = var.glue_role_arn

  command {
    script_location = var.s_location
  }
}
