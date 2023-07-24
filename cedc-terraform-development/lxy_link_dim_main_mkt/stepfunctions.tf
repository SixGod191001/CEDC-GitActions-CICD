module "state_machine" {
  source            = "../../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = "cedc-sfn-workflow-glue-job-xy"
  role_name          = "step_functions_execute_role"
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
}