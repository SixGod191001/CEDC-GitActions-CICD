variable "glue_database_name" {
  description = "The glue database name"
  type = string
}

variable "glue_catalog_table_list" {
  description = "The glue catalog table list"
  type = string
}

variable "dependencies" {
  type    = list(string)
  default = []
}
