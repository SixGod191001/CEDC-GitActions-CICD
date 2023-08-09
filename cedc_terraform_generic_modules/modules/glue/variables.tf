variable "job_name" {
  description = "The name of the job"
  type = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "s3_path_header" {
  description = "The s3 path header"
  type = string
}

variable "s3_path_tail" {
  description = "The s3 path tail"
  type = string
}

variable "scripts_bucket_name" {
  description = "The burcket of the job script"
  type = string
}

variable "worker_number" {
  description = "The number of workers"
  type = number
}
variable "work_type" {
  description = "The work type"
  type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}

variable "glue_version" {
  type = string
  default = ""
}
