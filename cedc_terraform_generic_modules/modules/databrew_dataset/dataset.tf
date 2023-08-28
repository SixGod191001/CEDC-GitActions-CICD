resource "awscc_databrew_dataset" "dataset" {
  name  = var.name
  input = {
    s3_input_definition = {
      bucket    = var.bucket
      key       = var.key
    }
  }
  format_options = {
    csv = {
      delimiter   = var.delimiter
      header_row  = var.header_row
    }
  }
}
