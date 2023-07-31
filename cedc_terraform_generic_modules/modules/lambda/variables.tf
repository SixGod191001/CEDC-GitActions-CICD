variable "function_name" {
  description = "The name of the lambda"
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

variable "role_name" {
  description = "The role_name of the lambda"
  type = string
}
