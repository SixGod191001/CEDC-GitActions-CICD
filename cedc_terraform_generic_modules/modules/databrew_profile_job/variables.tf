variable "name" {
  description = "Job name"
  type        = string
  required    = true
}

variable "role_name" {
  description = "Role name"
  type        = string
  required    = true
}

variable "type" {
  description    = "Job type"
  type           = string
  required       = true
  allowed_values = ["PROFILE", "RECIPE"]
}

variable "mode" {
  description    = "Sample configuration mode for profile jobs"
  type           = string
  allowed_values = ["FULL_DATASET", "CUSTOM_ROWS"]
  default        = null
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
  default     = null
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
  description    = "Encryption mode, SSE-KMS mode needs encryption_key_arn"
  type           = string
  allowed_values = ["SSE-KMS", "SSE-S3"]
  default        = null
}

variable "encryption_key_arn" {
  description = "Encryption Key Arn"
  type        = string
  default     = null
}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type        = list(string)
  default     = []
}
