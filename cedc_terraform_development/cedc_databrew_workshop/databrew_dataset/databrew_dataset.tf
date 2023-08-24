module "databrew_dataset_customers" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "jacky-customers"
  database_name  = "testdb"
  table_name     = "customers"
}

module "databrew_dataset_sales" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "jacky-sales"
  database_name  = "testdb"
  table_name     = "sales"
}
