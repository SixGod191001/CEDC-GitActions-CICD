
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

recipe = {
  name        = "yuewi_profile_recipe"
  description = "Profile Recipe"
  steps       = [
    {
      action_operation = {
        action_type = "PROFILING"
        parameters  = {
          column_name = "Customer_Id"
        }
      }
    },
    {
      action_operation = {
        action_type = "PROFILING"
        parameters  = {
          regex_pattern = "Total.*"
        }
      }
    }
  ]
}
