variable "role_name" {
  type        = string
  description = "Name of the IAM role"
  default     = "gitactions_eventbridge_role"
}

variable "policy_name" {
  type        = string
  description = "Name of the IAM policy"
  default     = "gitactions_lambda_execution_policy"
}

variable "policy_description" {
  type        = string
  description = "Description of the IAM policy"
  default     = "Policy for Lambda Execution"
}

variable "policy_actions" {
  type        = list(string)
  description = "List of actions allowed by the IAM policy"
  default     = ["lambda:InvokeFunction"]
}