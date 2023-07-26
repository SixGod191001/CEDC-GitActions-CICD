module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "glue_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["glue_invoke_s3_policy"]
  policy_contents = [file("${path.module}/glue_invoke_s3_policy.json")]
}