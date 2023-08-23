module "databrew_profile_job" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name         = "youqun Customer profile job"
  role_name    = "youqun_databrew_common_role"
  dataset_name = "youqun-customers"
  mode         = "FULL_DATASET"
  bucket       = "scriptbucket"
  bucket_owner = "ETL_Account"
  key          = "youqun_databrew_workshop/profile-output/"
  entity_types = ["USA_ALL"]
  dependencies = [
    "cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}
