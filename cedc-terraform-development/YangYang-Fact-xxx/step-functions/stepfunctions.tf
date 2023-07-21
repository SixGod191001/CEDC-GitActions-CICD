module "state_machine" {
  source            = "../../../cedc-terraform-generic-modules/modules/step-functions"
  state_machine_name = "aws_sfn_state_machine"
  role_arn          = module.__cedc_terraform_development_iam_step_functions.step_functions_iam_role.iam_role_arn
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
}