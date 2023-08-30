module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "youqun-customers"
  bucket         = "gitaction-s3-terraform"
  key            = "cedc_databrew_workshop/datafiles/customers/customers.csv"
}

module "databrew_dataset_sales" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "youqun-sales"
  bucket         = "gitaction-s3-terraform"
  key            = "cedc_databrew_workshop/datafiles/sales/sales.csv"
  depends_on     = [module.databrew_dataset]
}
