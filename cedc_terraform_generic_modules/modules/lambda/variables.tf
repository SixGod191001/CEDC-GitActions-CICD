variable "lambda_name" {
  description = "The name of the lambda"
  type = string
}

variable "lambda_role_arn" {
  description = "The lambda role arn"
  type = string
}

variable "lambda_handler" {
  description = "The handler of the lambda"
  type = string
}

variable "lambda_runtime" {
  description = "The runtime of the lambda"
  type = string
}

variable "source_code_hash" {
  description = "The source code of the lambda"
  type = string
}
