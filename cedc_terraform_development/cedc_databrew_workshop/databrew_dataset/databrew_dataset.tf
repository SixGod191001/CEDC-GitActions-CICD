module "databrew_dataset" {
  source         = "../../../cedc_terraform_generic_modules/modules/databrew_dataset"
  name           = "yuwei-dataset"
  bucket         = "gitaction-s3-terraform"
  key            = "yuwei_databrew_workshop/datafiles/"
}
