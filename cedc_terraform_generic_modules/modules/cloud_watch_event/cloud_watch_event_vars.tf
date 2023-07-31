variable "role_name" {
    type = string
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

