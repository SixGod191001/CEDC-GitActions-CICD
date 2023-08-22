module "cedc_databrew_common_role" {
  source                  = "../../cedc_terraform_generic_modules/modules/iam"
  use_service_role_arn    = true
  role_name               = "liuzhu_databrew_common_role"
  trust_policy            = file("${path.module}/trust_policy.json")
  system_policy_names     = ["AWSGlueDataBrewServiceRole"]
  custom_policy_names     = ["liuzhu_AwsGlueDataBrewServicePolicyForOutputS3-ID" , "liuzhu_AwsGlueDataBrewServicePolicyForInputS3-ID"]
  custom_policy_contents  = [file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3-ID.json"),file("${path.module}/AwsGlueDataBrewServicePolicyForOutputS3-ID.json")]
  
}