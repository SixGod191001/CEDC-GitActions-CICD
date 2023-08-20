module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "jacky-customers"
  database_name  = "testdb"
  table_name     = "customers"
}




