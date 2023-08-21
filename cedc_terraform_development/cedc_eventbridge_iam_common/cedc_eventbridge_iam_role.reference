module "eventbridge_invoke_lambda_iam_role" {
  source                     = "../../cedc_terraform_generic_modules/modules/iam"
  role_name                  = "jacky_eventbridge_invoke_lambda_execute_role"
  trust_policy               = file("${path.module}/eventbridge_trust_policy.json")
  custom_policy_names        = ["jacky_invoke_lambda_policy"]
  custom_policy_contents     = [file("${path.module}/eventbridge_invoke_lambda_policy.json")]
}
