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

variable "event_pattern_details" {
    type = string
    default = null
}

variable "event_enabled" {
    type = bool
    default = true
}
