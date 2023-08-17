locals {
  table_list = fileset(var.table_strctr_file_path, var.glue_catalog_table_list)
} 

resource "aws_glue_catalog_database" "create_catalog_database" {

 for_each    = { for file in local.table_list : file => regex("[a-zA-Z\\-0-9_]+",file) }
 name        = jsondecode(file("${var.table_strctr_file_path}/${each.key}")).database
}
