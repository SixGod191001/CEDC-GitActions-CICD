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
  policy_arn  = "[arn:aws:iam::aws:policy/AmazonS3FullAccess]"

  roles = concat(
    [aws_iam_role.iam_role.name],
    [for i in aws_iam_policy.iam_policy : i.arn]
  )
}

output "iam_role_arn" {
  value = aws_iam_role.iam_role.arn
}
