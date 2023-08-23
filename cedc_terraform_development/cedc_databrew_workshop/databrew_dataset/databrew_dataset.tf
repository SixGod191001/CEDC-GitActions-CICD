module "databrew_dataset01" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "yuwei-customers"
  database_name  = "testdb"
  table_name     = "customers"
}
module "databrew_dataset02" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "yuwei-sales"
  database_name  = "testdb"
  table_name     = "sales"
}

