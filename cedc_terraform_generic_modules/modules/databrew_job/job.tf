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

  recipe                    = local.recipe
  encryption_mode           = var.encryption_mode
  encryption_key_arn        = local.encryption_key_arn
  max_capacity              = var.max_capacity
  timeout                   = var.timeout
  max_retries               = var.max_reties
  tags                      = var.tags
  log_subscription          = var.log_subscription
  profile_configuration     = local.profile_configuration
  validation_configurations = local.validation_configurations
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
  allowed_statistics = length(var.allowed_statistics) != 0 ? { statistics = var.allowed_statistics } : null
  recipe             = var.recipe_name != null ? { name = var.recipe_name, version = var.recipe_version } : null

  entity_detector_configuration = length(var.entity_types) != 0 ? {
    entity_types = var.entity_types
    statistics   = local.allowed_statistics
  } : null

  dataset_statistics_configuration = length(var.dataset_statistics_configuration.included_statistics) != 0 ? var.dataset_statistics_configuration : null

  profile_columns = length(var.profile_columns) != 0 ? var.profile_columns : null

  validation_configurations = length(var.validation_configurations) != 0 ? var.validation_configurations : null

  profile_configuration = {
    dataset_statistics_configuration = local.dataset_statistics_configuration
    column_statistics_configurations = var.column_statistics_configurations
    entity_detector_configuration    = local.entity_detector_configuration
    profile_columns                  = local.profile_columns
  }
}

#recipe create
resource "aws_databrew_job" "example_job" {
  name          = var.job_name
  dataset_name  = var.dataset_name
  type          = var.job_type
  role_arn      = var.role_arn
  log_subscription = var.log_subscription

  recipe {
    # Recipe configuration here
    # Example: Using a 'CSV' recipe
    type = "CSV"
    format_options {
      delimiter = ","
    }
  }

  # Other job configuration here
  # Example: Output options
  outputs {
    s3 {
      bucket_name = "example-bucket"
      file_name  = "output.csv"
    }
  }
}
