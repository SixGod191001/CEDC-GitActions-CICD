module "databrew_profile_job" {
    source         = "../../../cedc_terraform_generic_modules/modules/databrew_job"
    name           = "liuzhu Customer profile job"
    type           = "PROFILE"
    mode           = "FULL_DATASET"
    dataset_name   = "liuzhu-customers"
    bucket         = "scriptbucket"
    bucket_owner   = "ETL_Account"
    key            = "liuzhu_databrew_workshop/profile-output/"
    role_name      = "liuzhu_databrew_common_role"
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
    dependencies = [
        module.cedc_databrew_common_role.role_name,
        module.databrew_dataset_customers.name
    ]
}