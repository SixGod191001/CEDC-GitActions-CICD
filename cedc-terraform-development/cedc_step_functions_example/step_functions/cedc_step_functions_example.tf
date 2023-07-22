module "state_machine" {
  source            = "../../../cedc-terraform-generic-modules/modules/step-functions"
  state_machine_name = "aws_sfn_state_machine1"
  role_name          = "step_functions_execute_role"
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
}