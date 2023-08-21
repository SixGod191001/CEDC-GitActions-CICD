resource "awscc_databrew_job" "profile_job" {
  name       = var.name
  role_arn   = data.aws_iam_role.role_arn.arn
  type       = var.type
  job_sample = {
    mode = var.mode
    size = local.size

  }
  dataset_name    = var.dataset_name
  output_location = {
    bucket       = data.aws_ssm_parameter.bucket.value
    bucket_owner = data.aws_ssm_parameter.bucket_owner.value
    key          = local.key
  }
  encryption_mode       = var.encryption_mode
  encryption_key_arn    = local.encryption_key_arn
#  profile_configuration = {
#    dataset_statistics_configuration = {
#
#    }
#    column_statistics_configurations = {
#
#    }
#  }
}


data "aws_iam_role" "role_arn" {
  name = var.role_name
}

data "aws_ssm_parameter" "bucket" {
  name = var.bucket
}

data "aws_ssm_parameter" "bucket_owner" {
  name = var.bucket_owner
}

locals {
  size               = var.mode == "FULL_DATASET" ? null : var.size
  key                = var.bucket != null ? var.key : null
  encryption_key_arn = var.encryption_key_arn == "SSE-S3" ? null : var.encryption_key_arn
}