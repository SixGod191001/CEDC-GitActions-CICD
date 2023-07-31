module "state_machine_mc" {
  source            = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = "cedc-sfn-workflow-state-machine-mc"
  role_name          = "step_functions_execute_role"
  definition        = file("${path.module}/state_machine_definition_mc.json")
  tags              = { "project" = "CEDC" }
  dependencies       = ["cedc_terraform_development/cedc_step_functions_iam_common"]
}
