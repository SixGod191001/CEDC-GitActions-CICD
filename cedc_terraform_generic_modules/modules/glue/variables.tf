variable "job_name" {
  description = "The name of the job"
  type = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "glue_execute_role"
}

variable "s3_key" {
  description = "The s3 path tail"
  type = string
}

variable "scripts_bucket_name" {
  description = "The burcket of the job script"
  type = string
  default = "scriptbucket"
}

variable "worker_number" {
  description = "The number of workers"
  type = number
  default = 2
}
variable "work_type" {
  description = "The work type"
  type = string
  default = "Standard"
}

variable "dependencies" {
  type    = list(string)
  default = ["cedc_terraform_development/cedc_glue_iam_common"]
}

variable "glue_version" {
  type = string
  default = "2.0"
}
