
module "databrew_profile_job" {
  source                           = "../../../cedc_terraform_generic_modules/modules/databrew_job"
  name                             = "yuwei customer profile job"
  role_name                        = "yuwei_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "yuwei-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "liuyuwei_databrew_workshop/profile-output/"
  entity_types                     = ["USA_ALL"]
  dataset_statistics_configuration = {
    included_statistics = ["CORRELATION"]
    overrides           = [
      {
        parameters = {
          "columnSelectors" : "[{\"name\":\"Customer_Id\"}, {\"regex\":\"Total.*\"}]"
        }
        statistic = "CORRELATION"
      }
    ]
  }
  dependencies = [
   "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}

module "databrew_job" {
  source        = "../../../cedc_terraform_generic_modules/modules/databrew_job"
  job_name      = "yuwei_recipe_job"
  dataset_name  = "yuwei_customers"
  job_type      = "profile"
  role_arn      = "yuwei_databrew_common_role"
  log_subscription = true
  recipe = {
    # Recipe configuration here
  }
}
