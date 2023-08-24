module "databrew_profile_job" {
  source                           = "../../../cedc_terraform_generic_modules/modules/databrew_profile_job"
  name                             = "jacky Customer profile job"
  role_name                        = "jacky_databrew_common_role"
  dataset_name                     = "jacky-customers"
  mode                             = "FULL_DATASET"
  bucket                           = "scriptbucket"
  bucket_owner                     = "ETL_Account"
  key                              = "jacky_databrew_workshop/profile-output/"
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
#  column_statistics_configurations = [
#    {
#      selectors : [
#        { name : "name" },
#        { regex : "middle*" }
#      ],
#      statistics : {
#        included_statistics : ["CORRELATION", "DUPLICATE_ROWS_COUNT"]
#        overrides : [
#          {
#            statistic : "VALUE_DISTRIBUTION",
#            parameters : {
#              "binNumber" : "10"
#            }
#          }
#        ]
#      }
#    }
#  ]

  dependencies = [
    "cedc_terraform_development/cedc_databrew_iam_common", "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
  ]
}
