variable "function_name" {
  description  = "The name of the lambda"
  type         = string
}

variable "handler" {
  description  = "The handler of the lambda"
  type         = string
  default      = "lambda_function.lambda_handler"
}

variable "runtime" {
  description  = "The runtime of the lambda"
  type         = string
  default      = "python3.9"
}

variable "role_name" {
  description  = "The role_name of the lambda"
  type         = string
  default      = "lambda_execute_role"
}

variable "scripts_bucket_name" {
  description  = "The s3 bucket of the lambda"
  type         = string
  default      = "scriptbucket"
}

variable "s3_key" {
  description  = "The s3 key of the lambda"
  type         = string
}

variable "dependencies" {
  description  = "The dependencies of the lambda"
  type         = list(string)
  default      = ["cedc_terraform_development/cedc_lambda_iam_common"]
}

