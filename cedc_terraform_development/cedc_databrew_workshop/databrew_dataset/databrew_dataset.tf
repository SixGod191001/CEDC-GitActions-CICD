module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "jacky_test dataset"
  database_name  = "testdb"
  table_name     = "dim_brand_csv"
}


