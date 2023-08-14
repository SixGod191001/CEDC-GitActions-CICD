variable "role_name" {
    type = string
    default  = "eventbridge_invoke_lambda_execute_role"
}

variable "dependencies" {
  type    = list(string)
  default = ["cedc_terraform_development/cedc_eventbridge_iam_common"]
}

variable "event_rule_name" {
   type     =  string  
}

variable "schedule_expression_details" {
    type    = string
    default = null
}

variable "event_pattern_details" {
    type    = string
    default = null
}

variable "event_enabled" {
    type     = bool
    default  = false
}
