 module "databrew_profile_job" {
   source                           = "../../../cedc_terraform_generic_modules/modules/databrew_job"
   name                             = "elaine customers profile job"
   role_name                        = "elaine_databrew_common_role"
   type                             = "PROFILE"
   dataset_name                     = "elaine-customers"
   mode                             = "FULL_DATASET"
   bucket                           = "scriptbucket"
   bucket_owner                     = "ETL_Account"
   key                              = "elaine_cedc_databrew_workshop/profile-output/"
   entity_types                     = ["USA_ALL"]
   dataset_statistics_configuration = {
     included_statistics = ["CORRELATION"]
     overrides           = [
       {
         parameters = {
           "columnSelectors" : "[{\"name\":\"Customer_Id\"}, {\"regex\":\"Middle.*\"}]"
         }
         statistic = "CORRELATION"
       }
     ]
   }
   dependencies = [
    "cedc_terraform_development/cedc_databrew_workshop/databrew_dataset"
   ]
 }