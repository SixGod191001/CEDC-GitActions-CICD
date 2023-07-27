module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "lambda_execute_role1"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["lambda_invoke_step_functions_policy.json"]
  policy_contents = [file("${path.module}/lambda_invoke_step_functions_policy.json")]
}
