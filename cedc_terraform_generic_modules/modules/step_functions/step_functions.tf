data "aws_iam_role" "state_machine_role" {
  name = var.role_name
  lifecycle {
    ignore_changes = [name]
  }
}

resource "null_resource" "dependency" {
  depends_on = [data.aws_iam_role.state_machine_role]
}

resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name        = var.state_machine_name
  role_arn    = data.aws_iam_role.state_machine_role.arn
  definition  = var.definition
  tags        = var.tags
  depends_on = [
    null_resource.dependency
  ]
}