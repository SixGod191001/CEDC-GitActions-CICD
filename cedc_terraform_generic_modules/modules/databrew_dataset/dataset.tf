resource "awscc_databrew_dataset" "dataset" {
  name  = var.name
  input = {
    data_catalog_input_definition = {
      database_name    = var.database_name
      table_name       = var.table_name
    }
  }
}


resource "awscc_databrew_datasets3" "datasets3" {
  name = var.name
  input = {
    s3_input_definition = {
      bucket = var.bucket
      key    = var.key
    }
  }

  format_options = {
    csv = {
      delimiter   = var.delimiter
      header_row  = var.header_row
    }
  }
}
