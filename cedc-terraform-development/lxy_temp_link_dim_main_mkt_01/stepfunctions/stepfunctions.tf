module "state_machine" {
  source            = "../../cedc-terraform-generic-modules/modules/step-functions"
  state_machine_name = "cedc_sm_workflow_glue_job_xy"
  role_arn          = aws_iam_role.step_functions_execute_role.arn
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
  depends_on        = [aws_iam_role.step_functions_execute_role]
}