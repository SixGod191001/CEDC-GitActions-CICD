module "eventbridge_invoke_lambda_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "eventbridge_invoke_lambda_execute_role"
  assume_role_policy = file("${path.module}/eventbridge_trust_policy.json")
  policy_names    = ["eventbridge_invoke_lambda_policy.json"]
  policy_contents = [file("${path.module}/eventbridge_invoke_lambda_policy.json")]
}
