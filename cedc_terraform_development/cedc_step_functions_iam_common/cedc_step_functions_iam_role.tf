module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "step_functions_execute_role"
  trust_policy = file("${path.module}/trust_policy.json")
  custom_policy_names    = ["step_functions_invoke_glue_policy"]
  custom_policy_contents = [file("${path.module}/step_functions_invoke_glue_policy.json")]
}