module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "liuzhu-dataset"
  bucket         = "gitaction-s3-terraform"
  key            = "liuzhu_databrew_workshop/datafiles/"
}
