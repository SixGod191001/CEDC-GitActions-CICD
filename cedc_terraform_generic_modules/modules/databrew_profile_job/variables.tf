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
  default     = "PROFILE"
  #  allowed_values = ["PROFILE", "RECIPE"]
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
  description = "Maximum number of units"
  type        = number
  default     = 5
}

variable "timeout" {
  description = "Job timeout (minutes)"
  type        = number
  default     = 60
}

variable "max_reties" {
  description = "Maximum number of times to retry job on failure"
  type        = number
  default     = 0
}

variable "tags" {
  description = "tags"
  type        = list(object({ key = string, value = string }))
  default     = [{ key = "project", value = "CEDC" }]
}

variable "log_subscription" {
  description = "Log subscription (ENABLE | DISABLE)"
  type        = string
  default     = "DISABLE"
}

variable "entity_types" {
  description = "PII categories (USA_ALL | USA_SSN | EMAIL | USA_ITIN | USA_PASSPORT_NUMBER | PHONE_NUMBER | USA_DRIVING_LICENSE | BANK_ACCOUNT | CREDIT_CARD | IP_ADDRESS | MAC_ADDRESS | USA_DEA_NUMBER | USA_HCPCS_CODE | USA_NATIONAL_PROVIDER_IDENTIFIER | USA_NATIONAL_DRUG_CODE | USA_HEALTH_INSURANCE_CLAIM_NUMBER | USA_MEDICARE_BENEFICIARY_IDENTIFIER | USA_CPT_CODE | PERSON_NAME | DATE)"
  type        = list(string)
  default     = []

}


variable "allowed_statistics" {
  description = "Configure the statistics that are allowed to be run on columns that contain detected entities. If AllowedStatistics is undefined, no statistics will be computed on columns that contain detected entities. "
  type        = list(string)
  default     = []
  # reference table: https://docs.aws.amazon.com/databrew/latest/dg/profile.configuration.html#statistics.table02

}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type        = list(string)
  default     = []
}
