locals {
  table_list = fileset(path.module, var.glue_catalog_table_list)
} 

resource "aws_glue_catalog_database" "create_catalog_database" {

 for_each    = { for file in local.table_list : file => regex("[a-zA-Z\\-0-9_]+",file) }
 name        = jsondecode(file("${path.module}/${each.key}")).database
}
