module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "youqun-customers"
  bucket         = "gitaction-s3-terraform"
  key            = "youqun_databrew/datafiles/customers/customers.csv"
}
