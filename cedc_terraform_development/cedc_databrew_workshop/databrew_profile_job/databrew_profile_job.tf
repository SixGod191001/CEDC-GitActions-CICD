module "databrew_profile_job" {
  source                           = "../../../cedc_terraform_generic_modules/modules/databrew_job"
  name                             = "haohao Customer profile job"
  role_name                        = "haohao_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "haohao-sales"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "haohao_databrew_workshop/profile-output/"
  entity_types                     = ["USA_ALL"] 
}
