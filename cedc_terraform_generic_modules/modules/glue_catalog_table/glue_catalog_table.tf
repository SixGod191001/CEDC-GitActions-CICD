resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = var.catalog_table_name
  database_name = var.catalog_database_name
}
