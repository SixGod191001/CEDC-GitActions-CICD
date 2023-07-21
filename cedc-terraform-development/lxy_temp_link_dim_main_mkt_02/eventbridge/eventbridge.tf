module "state_machine" {
  source            = "../../cedc-terraform-generic-modules/modules/eventbridge"
  eventbridgename = "aws_sfn_state_machine"
  role_arn          = aws_iam_role.eventbridge_execute_role.arn
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
  depends_on        = [aws_iam_role.step_functions_execute_role]
}