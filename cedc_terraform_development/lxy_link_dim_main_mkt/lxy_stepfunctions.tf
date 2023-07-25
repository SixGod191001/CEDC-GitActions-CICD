module "state_machine_xy" {
  source            = "../../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = "cedc-sfn-workflow-glue-job-xy"
  role_name          = step_functions_iam_role.arn
  definition        = file("${path.module}/state_machine_definition_lin.json")
  tags              = { "project" = "CEDC" }
}