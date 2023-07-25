module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "glue_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["step_functions_invoke_glue_policy"]
  policy_contents = [file("${path.module}/step_functions_invoke_glue_policy.json")]
}