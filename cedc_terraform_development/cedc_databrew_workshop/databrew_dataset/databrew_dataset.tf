module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "liuyuwei-dataset"
  bucket         = "gitaction-s3-terraform"
  key            = "cedc_databrew_workshop/datafiles/"
}
