resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name        = var.state_machine_name
  role_arn    = var.role_arn
  definition  = var.definition
  tags        = var.tags
  depends_on  = var.depends_on_resource
}