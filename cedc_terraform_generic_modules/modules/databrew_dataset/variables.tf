variable "name" {
  description = "dataset name"
  type        = string
}

variable "database_name" {
  description = "glue catalog database name"
  type        = string
}

variable "table_name" {
  description = "glue catalog table name"
  type        = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}
