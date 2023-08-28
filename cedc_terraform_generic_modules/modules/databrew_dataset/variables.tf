variable "name" {
  description = "The dataset name must contain 1-255 characters. Valid characters are alphanumeric (A-Z, a-z, 0-9), hyphen (-), period (.), and space."
  type        = string
}

#variable "database_name" {
#  description = "Glue catalog database name"
#  type        = string
#}
#
#variable "table_name" {
#  description = "Glue catalog table name"
#  type        = string
#}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type    = list(string)
  default = []
}

variable "bucket" {
  description = "S3 bucket name"
  type    = string
}

variable "key" {
  description = "S3 key name"
  type    = string
}

variable "delimiter" {
  description = "csv format"
  type        = string
  default     = ","
}

variable "header_row" {
  description = "csv format header row"
  type        = string
  default     = true
}
