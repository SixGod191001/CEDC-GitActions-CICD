variable "event_rule_name" {
    type = string
}

variable "permission_statement_id" {
    type = string
}

/*
variable "lambda_function_name" {
   type = string
}
*/

variable "execution_arn" {
   type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}
