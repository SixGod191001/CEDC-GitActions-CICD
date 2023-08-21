module "create_glue_catalog_table" {
  source                    = "../../cedc_terraform_generic_modules/modules/glue_catalog_table"
  table_strctr_file_path    = "${path.module}"
  glue_catalog_table_list   = "*_strctr.json"
  datafile_bucket_name      = "cicddevraw"
  s3_key                    = "source"
  #depends_on                = [module.create_glue_database]
}
