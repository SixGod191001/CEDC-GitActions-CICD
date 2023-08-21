module "cedc_databrew_common_role" {
  source                 = "../../cedc_terraform_generic_modules/modules/iam"
  role_name = "jacky_databrew_common_role"
  trust_policy = file("${path.module}/trust_policy.json")
  system_policy_names    = ["AWSGlueDataBrewServiceRole"]
  custom_policy_names    = ["jacky_AwsGlueDataBrewServicePolicyForOutputS3-ID", "jacky_AwsGlueDataBrewServicePolicyForInputS3-ID"]
  custom_policy_contents = [
    file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3-ID.json"), file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3-ID.json")
  ]
}






