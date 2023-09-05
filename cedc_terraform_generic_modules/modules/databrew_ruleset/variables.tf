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

variable "rules" {
  type        = list(object({
    check_expression  = string # Data quality check
    column_selectors  = list(object({
      name  = string
      regex = string
    }))
    disabled          = bool
    name              = string # Rule name
    substitution_map  = list(object({
      value           = string
      value_reference = string
    }))
    threshold         = object({
      type  = string # threshold.type value must be one of: ["GREATER_THAN_OR_EQUAL" "LESS_THAN_OR_EQUAL" "GREATER_THAN" "LESS_THAN"]
      unit  = string # threshold.unit value must be one of: ["COUNT""PERCENTAGE"]
      value = number
    })
  }))
  description = "List of the data quality rules in the ruleset"
}

variable "tags" {
  type        = list(object({
    key   = string
    value = string
  }))
  description = "List of tags for the Ruleset"
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
