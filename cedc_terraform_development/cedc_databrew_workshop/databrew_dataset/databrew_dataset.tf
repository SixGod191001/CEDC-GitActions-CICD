module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "macui-customers"
  database_name  = "testdb"
  table_name     = "customers"
}
