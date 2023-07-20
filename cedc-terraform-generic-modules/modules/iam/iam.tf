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
  count       = length(var.policy_names)
  policy_arn  = aws_iam_policy.iam_policy[count.index].arn
  roles       = [aws_iam_role.iam_role.name]
}