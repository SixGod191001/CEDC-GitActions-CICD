resource "awscc_databrew_job" "profile_job"{
  name       = var.name
  role_arn   = data.aws_iam_role.role_arn.arn
  type       = var.type
  job_sample = {
    mode = var.mode
    size = var.size
  }
  dataset_name    = var.dataset_name
  selected_file   = local.selected_file
  output_location = {
    bucket       = data.aws_ssm_parameter.bucket.value
    bucket_owner = var.bucket_owner != null ? data.aws_ssm_parameter.bucket_owner.value : data.aws_caller_identity.current.account_id
    key          = var.key
  }

  locals {
      selected_file = var.selected_file != "" ? "s3://bucket_name/path/to/files/${var.selected_file}" : null
  }
  

  profile_configuration = {
    entity_detector_configuration = {
                     entity_types = var.entity_types  #["person", "job_title", "email", "phone_number", "date", "time", "location", "organization"]
    }
}
}

data "aws_caller_identity" "current" {}

data "aws_iam_role" "role_arn" {
  name = var.role_name
}

data "aws_ssm_parameter" "bucket" {
  name = var.bucket
}

data "aws_ssm_parameter" "bucket_owner" {
  name = var.bucket_owner
}

