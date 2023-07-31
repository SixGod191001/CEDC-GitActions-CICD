module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "event_bridge_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["event_bridge_invoke_lambda_policy.json"]
  policy_contents = [file("${path.module}/event_bridge_invoke_lambda_policy.json")]
}