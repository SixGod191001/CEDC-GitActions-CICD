module "databrew_profile_job" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name         = "Jacky Customer profile job"
  role_name    = "jacky_databrew_common_role"
  dataset_name = "jacky-customers"
  mode         = "FULL_DATASET"
  bucket       = "scriptbucket"
  bucket_owner = "ETL_Account"
  key          = "jacky_databrew_workshop/profile-output/"
  entity_types = ["USA_ALL"]
  included_statistics = ["NONE"]
  dependencies = [
    "cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}
