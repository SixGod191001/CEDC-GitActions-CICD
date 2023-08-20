variable "name" {
  description = "The dataset name must contain 1-255 characters. Valid characters are alphanumeric (A-Z, a-z, 0-9), hyphen (-), period (.), and space."
  type        = string
}

variable "database_name" {
  description = "Glue catalog database name"
  type        = string
}

variable "table_name" {
  description = "Glue catalog table name"
  type        = string
}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type    = list(string)
  default = []
}
