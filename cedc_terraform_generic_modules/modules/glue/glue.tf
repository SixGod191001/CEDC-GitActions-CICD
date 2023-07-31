data "aws_iam_role" "glue_role" {
  name = var.role_name
}

resource "aws_glue_job" "glue_job" {
  name     = var.job_name
  role_arn = data.aws_iam_role.glue_role.arn

  command {
    script_location = var.s_location
  }
}
