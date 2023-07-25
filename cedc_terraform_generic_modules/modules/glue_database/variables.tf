variable "glue_database_name" {
  description = "The glue database name"
  type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}