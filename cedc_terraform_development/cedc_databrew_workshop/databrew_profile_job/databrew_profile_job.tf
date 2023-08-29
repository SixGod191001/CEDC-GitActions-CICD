module "databrew_profile_job" {
  source                           = "../../../cedc_terraform_generic_modules/modules/databrew_job"
  name                             = "youqun customer profile job"
  role_name                        = "youqun_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "haohao-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "youqun_databrew_workshop/profile-output/"
  entity_types                     = ["PERSON_NAME","DATE"]
}
