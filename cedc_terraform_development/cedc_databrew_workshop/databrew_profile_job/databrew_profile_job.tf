module "databrew_profile_job" {
  source                           = "../../../yuwei_terraform_generic_modules/modules/databrew_job"
  name                             = "yuwei customer profile job"
  role_name                        = "yuwei_databrew_common_role"
  type                             = "PROFILE"
  dataset_name                     = "yuwei-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "yuwei_databrew_workshop/profile-output/"
  entity_types                     = ["USA_ALL"]
  dataset_statistics_configuration = {
    included_statistics = ["CORRELATION"]
    overrides           = [
      {
        parameters = {
          "columnSelectors" : "[{\"name\":\"first_name\"}, {\"regex\":\"middle.*\"}]"
        }
        statistic = "CORRELATION"
      }
    ]
  }
}
