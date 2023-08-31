variable "name" {
  description = "Job name (required)"
  type        = string
}

variable "role_name" {
  description = "Role name (required)"
  type        = string
}

variable "type" {
  description = "Job type"
  type        = string
  default     = null
  #  allowed_values = ["PROFILE", "RECIPE"]
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = null
}

variable "recipe_name" {
  description = "Recipe name (Required)"
  type        = string
  default     = null
}

variable "recipe_version" {
  description = "Recipe version (Optional)"
  type        = string
  default     = null
}

variable "mode" {
  description = "Sample configuration mode for profile jobs (FULL_DATASET | CUSTOM_ROWS)"
  type        = string
  #  allowed_values = ["FULL_DATASET", "CUSTOM_ROWS"]
  default     = null
}

variable "size" {
  description = "Sample configuration size for profile jobs"
  type        = number
  default     = 20000
}

variable "dataset_name" {
  description = "Dataset name (required)"
  type        = string
  default     = null
}

variable "bucket" {
  description = "S3 bucket name for output location, please input the right ssm parameters for this bucket (required)"
  type        = string
}

variable "bucket_owner" {
  description = "Account number which owns S3 output location, please input the right ssm parameters for this account"
  type        = string
  default     = null
}

variable "key" {
  description = "S3 object key for output location"
  type        = string
  default     = null
}

variable "encryption_mode" {
  description = "Encryption mode, SSE-KMS mode needs encryption_key_arn (SSE-KMS | SSE-S3)"
  type        = string
  #  allowed_values = ["SSE-KMS", "SSE-S3"]
  default     = null
}

variable "encryption_key_arn" {
  description = "Encryption Key Arn"
  type        = string
  default     = null
}

variable "max_capacity" {
  description = "Advanced job settings - Maximum number of units"
  type        = number
  default     = 5
}

variable "timeout" {
  description = "Advanced job settings - Job timeout (minutes)"
  type        = number
  default     = 60
}

variable "max_reties" {
  description = "Advanced job settings - Maximum number of times to retry job on failure"
  type        = number
  default     = 0
}

variable "tags" {
  description = "tags"
  type        = list(object({ key = string, value = string }))
  default     = [{ key = "project", value = "CEDC" }]
}

variable "log_subscription" {
  description = "Advanced job settings - CloudWatch logs (ENABLE | DISABLE)"
  type        = string
  default     = "DISABLE"
}

variable "entity_types" {
  description = "Dataset level configurations - PII categories (USA_ALL | USA_SSN | EMAIL | USA_ITIN | USA_PASSPORT_NUMBER | PHONE_NUMBER | USA_DRIVING_LICENSE | BANK_ACCOUNT | CREDIT_CARD | IP_ADDRESS | MAC_ADDRESS | USA_DEA_NUMBER | USA_HCPCS_CODE | USA_NATIONAL_PROVIDER_IDENTIFIER | USA_NATIONAL_DRUG_CODE | USA_HEALTH_INSURANCE_CLAIM_NUMBER | USA_MEDICARE_BENEFICIARY_IDENTIFIER | USA_CPT_CODE | PERSON_NAME | DATE)"
  type        = list(string)
  default     = []

}

variable "allowed_statistics" {
  description = "Dataset level configurations - PII statistics"
  type        = list(string)
  default     = []
  # reference PII table: https://docs.aws.amazon.com/databrew/latest/dg/profile.configuration.html#statistics.table02
}

variable "dataset_statistics_configuration" {
  type = object({
    included_statistics = list(string)
    overrides           = list(object({
      parameters = map(string)
      statistic  = string
    }))
  })
  default = {
    included_statistics = []
    overrides           = []
  }
}
# example
#  {
#    included_statistics = ["CORRELATION"]
#    overrides = [
#      {
#        parameters = {
#          "columnSelectors": "[{\"name\":\"first_name\"}, {\"regex\":\"middle.*\"}]"
#        }
#        statistic = "CORRELATION"
#      }
#    ]
#  }

variable "validation_configurations" {
  description = "Data quality rules configuration"
  type        = list(object({ ruleset_arn = string, validation_mode = string }))
  default     = []
}

variable "column_statistics_configurations" {
  description = "Configuration for column statistics example - [{ selectors: [{name: \"example\"}, {regex: \"example*\"}], statistics: { included_statistics: [\"CORRELATION\", \"DUPLICATE_ROWS_COUNT\"], overrides: [{ statistic: \"VALUE_DISTRIBUTION\", parameters: { \"binNumber\": \"10\" } }] } }]"
  type        = list(object({
    statistics = object({
      included_statistics = optional(list(string))
      overrides           = optional(list(object({
        parameters = map(string)
        statistic  = string
      })))
    })
    selectors = optional(list(object({
      name  = optional(string)
      regex = optional(string)
    })))
  }))
  default = [
    {
      statistics = {
        included_statistics = null
        overrides           = null
      }
      selectors = null
    }
  ]
}
#column_statistics_configurations example:
#{
#    selectors: [{name: "example"},
#                {regex: "example*"}
#    ],
#    statistics: {
#       included_statistics: ["CORRELATION", "DUPLICATE_ROWS_COUNT"]
#        overrides: [
#            {
#                statistic: "VALUE_DISTRIBUTION",
#                parameters: {
#                    "binNumber": "10"
#                }
#            }
#        ]
#    }
#}

variable "profile_columns" {
  description = "Profile columns configuration - profile_columns example: [{name: \"example\"}, {regex: \"example.*\"}]"
  type        = list(object({
    name  = optional(string)
    regex = optional(string)
  }))
  default = []
}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type        = list(string)
  default     = []
}

variable "job_name" {
  description = "DataBrew job name"
  type        = string
}
/*
variable "dataset_name" {
  description = "DataBrew dataset name"
  type        = string
}
*/
variable "job_type" {
  description = "DataBrew job type"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for DataBrew job"
  type        = string
}
/*
variable "log_subscription" {
  description = "CloudWatch log subscription for DataBrew job"
  type        = bool
}
*/
variable "recipe" {
  description = "DataBrew recipe configuration"
  type        = map
  default     = null
}
