module "glue_to_s3_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "glue_to_s3_execute_role"
  assume_role_policy = file("${path.module}/glue_trust_policy.json")
  policy_names    = ["glue_to_s3_policy"]
  policy_contents = [file("${path.module}/glue_to_s3_policy.json")]
}