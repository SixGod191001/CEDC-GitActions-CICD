module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "yuwei-customers"
  bucket         = "gitaction-s3-terraform"
  key            = "liuyuwei_databrew_workshop/datafiles/customer.csv"
}

module "databrew_dataset_sales" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "yuwei-sales"
  bucket         = "gitaction-s3-terraform"
  key            = "liuyuwei_databrew_workshop/datafiles/customers/sales/"
  depends_on     = [module.databrew_dataset]
}
