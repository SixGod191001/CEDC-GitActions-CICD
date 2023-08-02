variable "event_rule_name" {
    type = string
}

variable "target_id" {
   type = string
}

variable "arn_details" {
   type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}
