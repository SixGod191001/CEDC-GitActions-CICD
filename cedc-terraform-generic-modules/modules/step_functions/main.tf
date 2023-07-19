module "iam" {
  source = "cedc-terraform-generic-modules\modules\iam\stepfunctions-role.tf"

  // 这里使用 module1 的其他输入变量
}


resource "aws_sfn_state_machine" "aws_sfn_state_machine" {
  name     = var.name
  role_arn = gitactions_eventbridge_role_arn 

  definition = var.definition
  tags = var.tags

  depends_on = [module.module1]
}