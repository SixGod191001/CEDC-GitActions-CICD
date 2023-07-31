variable "function_name" {
  description = "The name of the lambda"
  type = string
}

variable "lambda_role_arn" {
  description = "The arn of the lambda role"
  type = string
}

variable "handler" {
  description = "The handler of the lambda"
  type = string
}

variable "runtime" {
  description = "The runtime of the lambda"
  type = string
}

