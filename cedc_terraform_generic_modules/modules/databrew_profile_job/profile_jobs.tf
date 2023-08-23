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
    bucket_owner = var.bucket_owner != null ? data.aws_ssm_parameter.bucket_owner.value : data.aws_caller_identity.current.account_id
    key          = var.key
  }
  encryption_mode       = var.encryption_mode
  encryption_key_arn    = local.encryption_key_arn
  max_capacity          = var.max_capacity
  timeout               = var.timeout
  max_retries           = var.max_reties
  tags                  = var.tags
  log_subscription      = var.log_subscription
  profile_configuration = {
    #    dataset_statistics_configuration = {}
    #    column_statistics_configurations = {}
    entity_detector_configuration = local.entity_detector_configuration
    #    profile_columns = {}
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

locals {
  size               = var.mode == "FULL_DATASET" ? null : var.size
  encryption_key_arn = var.encryption_mode == "SSE-S3" ? null : var.encryption_key_arn
  allowed_statistics = var.allowed_statistics != [] ? { statistics = var.allowed_statistics } : null
  entity_detector_configuration = var.entity_types != [] ? {
      entity_types       = var.entity_types
      statistics = local.allowed_statistics
    } : null
}