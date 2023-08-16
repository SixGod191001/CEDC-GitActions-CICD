#resource "aws_iam_role" "iam_role" {
#  name               = "glue_execute_role1"
#  assume_role_policy = file("${path.module}/trust_policy.json")
#}
#
## 如果policy没有对应json文件，默认去aws找系统Policy
##arn:aws:iam::aws:policy/CloudSearchFullAccess
#
#resource "aws_iam_policy_attachment" "iam_policy_attachment" {
#  name        = "attachment"
#  policy_arn  = "arn:aws:iam::aws:policy/CloudSearchFullAccess"
#  roles       = [aws_iam_role.iam_role.name]
#}
