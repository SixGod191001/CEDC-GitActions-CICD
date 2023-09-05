module "databrew_profile_job" {
  source                           = "../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name                             = "macui customer profile job"
  role_name                        = "macui_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "macui-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "macui_databrew_workshop/profile-output/"
  entity_types                     = ["PERSON_NAME","DATE"]
}
