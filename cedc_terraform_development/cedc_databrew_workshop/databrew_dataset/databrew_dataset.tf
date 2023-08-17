module "prepared_s3_objects" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "test dataset"
  database_name  = "1"
  table_name     = "dim_brand_csv"
}


