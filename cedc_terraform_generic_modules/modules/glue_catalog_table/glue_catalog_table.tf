locals {
  table_list        = fileset(path.module, var.glue_catalog_table_list)
} 

resource "aws_glue_catalog_table" "create_catalog_table" {

  for_each          = { for file in local.table_list : file => regex("[a-zA-Z\\-0-9_]+",file) }
  database_name     = jsondecode(file("${path.module}/${each.key}")).database                                                                       #aws_glue_catalog_database.create_catalog_database.name
  name              = jsondecode(file("${path.module}/${each.key}")).table_name                                                                     #local.table_structure.table_name

  #Storage Descriptor: Specify table's storage format and location
  storage_descriptor {
    input_format    = "org.apache.hadoop.mapred.TextInputFormat"
    output_format   = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    location        = "s3://cicddevraw/source/${jsondecode(file("${path.module}/${each.key}")).table_name}.csv"                                     #${each.value}/

    dynamic "columns" {
      iterator      = columns
      for_each      = jsondecode(file("${path.module}/${each.key}")).columns                                                                        #jsondecode(data.local_file.table_schema.content).columns               #local.table_structure.columns

        content {
          name      = columns.value.name
          type      = columns.value.type
        }
    }

    ser_de_info {
      name                  = "SerDe"
      serialization_library = "org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe"
      parameters = {
        "field.delim" = ","
      }
    }
  }
}
