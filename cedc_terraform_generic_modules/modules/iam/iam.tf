resource "aws_iam_role" "iam_role" {
  name               = var.role_name
  assume_role_policy = var.trust_policy
}

resource "aws_iam_policy" "iam_policy" {
  count  = length(var.custom_policy_names)
  name   = var.custom_policy_names[count.index]
  policy = var.custom_policy_contents[count.index]
}

resource "aws_iam_policy_attachment" "iam_custom_policy_attachment" {
  name       = "custom-policy-attachment-${var.custom_policy_names[count.index]}"
  count      = length(var.custom_policy_names)
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = aws_iam_policy.iam_policy[count.index].arn
}

resource "aws_iam_policy_attachment" "iam_system_policy_attachment" {
  name       = "system-policy-attachment-${each.key}"
  for_each   = toset(var.system_policy_names)
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = data.aws_iam_policy.system_policy[each.key].arn
}

data "aws_iam_policy" "system_policy" {
  for_each = toset(var.system_policy_names)
  name     = each.key
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 15"

  depends_on = [aws_iam_role.iam_role]
}

