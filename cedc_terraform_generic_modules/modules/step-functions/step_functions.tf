data "aws_iam_role" "state_machine_role" {
  name = var.role_name
}

resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name        = var.state_machine_name
  role_arn    = data.aws_iam_role.state_machine_role.arn
  definition  = var.definition
  tags        = var.tags
}