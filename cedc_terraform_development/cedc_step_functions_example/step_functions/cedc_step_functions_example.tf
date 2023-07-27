module "state_machine" {
  source             = "../../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = "aws_sfn_state_machine1"
  role_name          = "step_functions_execute_role"
  definition         = file("${path.module}/state_machine_definition.json")
  tags               = { "project" = "CEDC" }
  dependencies       = ["cedc_terraform_development/cedc_step_functions_iam_common"]
}
