variable "job_name" {
  description = "The name of the job"
  type = string
}

variable "glue_role_arn" {
  description = "The arn of the glue role"
  type = string
}

variable "s_location" {
  description = "The location of the job script"
  type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}