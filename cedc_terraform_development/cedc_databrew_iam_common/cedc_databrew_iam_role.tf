module "cedc_databrew_common_role" {
  source              = "../../cedc_terraform_generic_modules/modules/iam"
  role_name           = "macui_databrew_common_role1"
  trust_policy        = file("${path.module}/trust_policy.json")
  system_policy_names = ["AWSGlueDataBrewServiceRole"]
  custom_policy_names = [
    "macui_AwsGlueDataBrewServicePolicyForOutputS3-ID",
    "macui_AwsGlueDataBrewServicePolicyForInputS3-ID",
    "AwsGlueDataBrewServicePolicyGlueCatalog"
  ]
  custom_policy_contents = [
    file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3.json"),
    file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3.json"),
    file("${path.module}/AwsGlueDataBrewServicePolicyGlueCatalog.json")
  ]
}






