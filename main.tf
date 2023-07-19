# resource "aws_ssm_parameter" "foo" {
#     name = "foo"
#     type = "String"
#     value = "changedOnFeature5"
# }


module "IAM" {
  source = "git::https://github.com/SixGod191001/CEDC-GitActions-CICD/aws-services/modules/iam"

  # 可以在这里定义模块2所需的输入变量
}