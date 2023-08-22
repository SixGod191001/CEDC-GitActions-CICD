module "lambda_iam_role" {
  source                 = "../../cedc_terraform_generic_modules/modules/iam"
  role_name              = "liuzhu_lambda_execute_role"
  trust_policy           = file("${path.module}/trust_policy.json")
  custom_policy_names    = ["liuzhu_lambda_invoke_step_functions_policy"]
  custom_policy_contents = [file("${path.module}/lambda_invoke_step_functions_policy.json")]
}
