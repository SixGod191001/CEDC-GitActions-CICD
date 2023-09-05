module "databrew_profile_job" {
  source                           = "../../../cedc_terraform_generic_modules/modules/databrew_job"
  name                             = "kunyuan customer profile job"
  role_name                        = "kunyuan_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "kunyuan-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "kunyuan_databrew_workshop/profile-output/"
  entity_types                     = ["PERSON_NAME","DATE"]
}
