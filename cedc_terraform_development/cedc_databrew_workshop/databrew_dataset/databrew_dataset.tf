module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "jyuwei-customers"
  database_name  = "testdb"
  table_name     = "yuwei_databrew_workshop/datafiles/customers/customers.csv"
}
