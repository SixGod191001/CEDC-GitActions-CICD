variable "table_strctr_file_path" {
  description = "The glue catalog table list"
  type = string
}

variable "glue_catalog_table_list" {
  description = "The glue catalog table list"
  type = string
}

variable "datafile_bucket_name" {
  description = "The burcket of the file"
  type = string
}

variable "s3_key" {
  description = "The s3 path tail"
  type        = string
  
}
