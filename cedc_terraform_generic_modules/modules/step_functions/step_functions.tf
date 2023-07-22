data "aws_iam_role" "state_machine_role" {
  count = var.role_exists ? 1 : 0
  name  = var.role_name
}

resource "null_resource" "dependency" {
  depends_on = [data.aws_iam_role.state_machine_role]
}

resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name        = var.state_machine_name
  role_arn    = var.role_exists ? data.aws_iam_role.state_machine_role[0].arn : ""
  definition  = var.definition
  tags        = var.tags
  depends_on = [
    null_resource.dependency
  ]
}