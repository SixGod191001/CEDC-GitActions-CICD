module "aws_lambda" {
  source            = "../../cedc-terraform-generic-modules/modules/lambda"
  state_machine_name = "cedc-eventbridge-trigger-lambda-xy"
  role_arn          = aws_iam_role."lambda arn"
  definition        = file("${path.module}/state_machine_definition.json")
  # tags              = { "project" = "CEDC" }
  depends_on        = [aws_iam_role.step_functions_execute_role]
}