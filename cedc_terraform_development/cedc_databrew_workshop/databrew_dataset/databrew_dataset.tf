module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "liuzhu-customers"
  bucket         = "s3://gitaction-s3-terraform/databrew_workshop/datafiles/customers/customers.csv"
}
