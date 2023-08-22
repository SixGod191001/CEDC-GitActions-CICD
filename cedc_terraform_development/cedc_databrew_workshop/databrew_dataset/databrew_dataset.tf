module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/datasets3"
  name           = "haohao_customers"
  bucket         = "gitaction-s3-terraform"
  key            = "haohao_databrew_workshop/datafiles/customers/customers.csv"
}
