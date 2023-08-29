variable "ruleset_description" {
  type        = string
  default     = null
  description = "Description of the Ruleset"
}

variable "ruleset_name" {
  type        = string
  default     = null
  description = "Name of the Ruleset"
}

variable "check_expression" {
  type        = string  # Data quality check
  default     = null
  description = ""
}

variable "name" {
  type        = string
  default     = null
  description = "Name of the Rule"
}

variable "disabled" {
  type        = boolean
  default     = false
  description = ""
}

variable "regex" {
  type        = string
  default     = null
  description = ""
}

variable "value" {
  type        = number
  default     = null
  description = ""
}

variable "type" {
  type        = string
  default     = null  # threshold.type value must be one of: ["GREATER_THAN_OR_EQUAL" "LESS_THAN_OR_EQUAL" "GREATER_THAN" "LESS_THAN"]
  description = ""
}

variable "unit" {
  type        = string
  default     = null  # threshold.unit value must be one of: ["COUNT""PERCENTAGE"]
  description = ""
}

variable "region" {
  type        = string
  default     = null
  description = "The AWS region"
}

variable "ssm_name_for_account_number" {
  type        = string
  default     = null
  description = "The SSM parameter name for the AWS account number"
}

variable "dataset_name" {
  type        = string
  default     = null
  description = "Name of the dataset"
}

variable "dependencies" {
  type    = list(string)
  default = []
}
