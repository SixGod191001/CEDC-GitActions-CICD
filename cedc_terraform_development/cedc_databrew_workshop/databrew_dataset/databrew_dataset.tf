module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "kunyuan-datafiles"
  bucket         = "gitaction-s3-terraform"
  key            = "kunyuan_databrew_workshop/datafiles/"
}
