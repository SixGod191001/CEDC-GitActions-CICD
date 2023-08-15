variable "lambda_function_name" {
    type = string
}

variable "event_rule_name" {
    type = string
}

variable "target_id" {
   type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}
