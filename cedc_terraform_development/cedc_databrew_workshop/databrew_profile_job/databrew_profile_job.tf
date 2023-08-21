module "databrew_profile_job" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name         = "Jacky Customer profile job"
  role_name    = "jacky_databrew_common_role"
  type         = "PROFILE"
  mode         = "FULL_DATASET"
  dependencies = [
    "cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}
