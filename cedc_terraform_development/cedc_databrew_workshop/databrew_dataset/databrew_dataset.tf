module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "haohao-sales"
  bucket         = "gitaction-s3-terraform"
  key            = "haohao_databrew_workshop/datafiles/customers/sales/"
}
