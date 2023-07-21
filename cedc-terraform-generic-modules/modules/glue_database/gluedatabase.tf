resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = var.glue_database_name
}

variable "glue_database_name" {
  description = "The glue database name"
  type = string
}