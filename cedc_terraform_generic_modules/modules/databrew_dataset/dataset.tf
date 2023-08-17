resource "aws_glue_databrew_dataset" "example_dataset" {
  name             = var.name
  input = {
    data_catalog_input_definition = {
      database_name    = var.database_name
      table_name       = var.table_name
    }
  }
}