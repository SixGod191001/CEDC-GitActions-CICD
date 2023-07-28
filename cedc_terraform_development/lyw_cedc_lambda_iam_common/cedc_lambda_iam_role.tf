module "lambda_to_stepfunctions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "lambda_to_stepfunctions_execute_role0vic"
  assume_role_policy = file("${path.module}/lambda_trust_policy.json")
  policy_names    = ["lambda_to_stepfunctions_policy"]
  policy_contents = [file("${path.module}/lambda_to_stepfunctions_policy.json")]
}
