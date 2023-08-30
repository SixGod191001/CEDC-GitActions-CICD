module "databrew_dataset_customers" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "liuzhu-customers"
  bucket         = "gitaction-s3-terraform"
  key            = "liuzhu_databrew_workshop/datafiles/customers/customers.csv"
}
module "databrew_dataset_sales" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "liuzhu-sales"
  bucket         = "gitaction-s3-terraform"
  key            = "liuzhu_databrew_workshop/datafiles/sales/sales.csv"
}
