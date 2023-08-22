variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "trust_policy"{
  description = "trust policy"
  type        = string
}

variable "custom_policy_names" {
  description = "A list of custom policy names"
  type        = list(string)
  default     = []
}

variable "custom_policy_contents" {
  description = "A list of custom policy contents"
  type        = list(string)
  default     = []
}

variable "system_policy_names" {
  description = "A list of system policy names"
  type        = list(string)
  default     = []
}

variable "ssm_parameter_name_for_s3_bucket" {
  description = "A list of ssm parameter name for s3 bucket cross all the ENV"
  type        = list(string)
  default     = []
}

variable "use_service_role_arn" {
  description = "Whether to use service-role ARN"
  type        = bool
  default     = false
}