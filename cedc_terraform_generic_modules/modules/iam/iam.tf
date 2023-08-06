resource "aws_iam_role" "iam_role" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "iam_policy" {
  count       = length(var.policy_names)
  name        = var.policy_names[count.index]
  policy      = var.policy_contents[count.index]
}

resource "aws_iam_policy_attachment" "iam_policy_attachment" {
  name        = "attachment"
  count       = length(var.policy_names)
  policy_arn  = aws_iam_policy.iam_policy[count.index].arn
  roles       = [aws_iam_role.iam_role.name]
}

resource "aws_iam_policy_attachment" "iam_policy_attachment1" {
  policy_arn  = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  roles       = [aws_iam_role.iam_role.name]
}

resource "aws_iam_policy_attachment" "iam_policy_attachment2" {
  policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  roles       = "glue_execute_role"
}

output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
}
