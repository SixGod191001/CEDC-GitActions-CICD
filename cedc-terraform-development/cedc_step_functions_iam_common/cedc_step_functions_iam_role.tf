module "step_functions_iam_role" {
  source          = "../../cedc-terraform-generic-modules/modules/iam"
  role_name       = "step_functions_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["step_functions_invoke_lambda_policy"]
  policy_contents = [file("${path.module}/step_functions_invoke_lambda_policy.json")]
}