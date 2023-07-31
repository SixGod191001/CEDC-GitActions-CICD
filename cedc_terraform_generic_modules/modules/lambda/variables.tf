variable "name" {
  description = "The name of the lambda"
  type = string
}

variable "role_arn" {
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

variable "source_code_hash" {
  description = "The source code of the lambda"
  type = string
}
