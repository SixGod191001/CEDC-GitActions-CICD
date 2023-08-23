variable "name" {
  description = "Job name"
  type        = string
}

variable "role_name" {
  description = "Role name"
  type        = string
}

variable "type" {
  description = "Job type"
  type        = string
  #  allowed_values = ["PROFILE", "RECIPE"]
}

variable "mode" {
  description = "Sample configuration mode for profile jobs"
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
  description = "Dataset name"
  type        = string
  default     = null
}

variable "bucket" {
  description = "S3 bucket name for output location, please input the right ssm parameters for this bucket"
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
  description = "Encryption mode, SSE-KMS mode needs encryption_key_arn"
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

variable "dependencies" {
  description = "Cross folder module dependencies"
  type        = list(string)
  default     = []
}
