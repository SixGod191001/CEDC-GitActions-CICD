variable "job_name" {
  description = "The name of the job"
  type = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "s_location" {
  description = "The location of the job script"
  type = string
}

variable "definition" {
  description = "The definition of the glue"
  type        = string
}

variable "tags" {
  description = "The tag of glue"
  type        = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}

