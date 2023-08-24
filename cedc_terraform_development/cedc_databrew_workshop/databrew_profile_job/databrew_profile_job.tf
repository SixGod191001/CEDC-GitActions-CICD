module "databrew_profile_job" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name         = "Macui Customer profile job"
  role_name    = "macui_databrew_common_role"
  type         = "PROFILE"
  dataset_name = "Macui-customers"
  mode         = "FULL_DATASET"
  bucket       = "scriptbucket"
  bucket_owner = "ETL_Account"
  key          = "macui_databrew_workshop/profile-output/"
  dependencies = [
    "cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}
