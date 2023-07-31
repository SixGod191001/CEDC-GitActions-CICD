variable "role_name" {
    type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}

variable "event_rule_name" {
    type = string
}

variable "schedule_expression_details" {
    type = string
    default = null
}

variable "event_enabled" {
    type = bool
    default = true
}

variable "arn_details" {
    type = string
}

variable "empty_input" {
    type = bool
    default =false
}

variable "input" {
    type = string
    default = ""
}

variable "function_details_name" {
    type = string
    default = null
}


