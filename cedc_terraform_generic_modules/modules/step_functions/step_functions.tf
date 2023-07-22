locals {
  use_data_block = can(data.aws_iam_role.state_machine_role)
  role_arn       = local.use_data_block ? data.aws_iam_role.state_machine_role.arn : ""
}

data "aws_iam_role" "state_machine_role" {
  name = var.role_name
}

resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name       = var.state_machine_name
  role_arn   = local.role_arn
  definition = var.definition
  tags       = var.tags
  depends_on = [
    data.aws_iam_role.state_machine_role
  ]
}