resource "aws_iam_role" "iam_role" {
  name               = var.role_name
  assume_role_policy = var.trust_policy
}

resource "aws_iam_policy" "iam_policy" {
  count       = length(var.custom_policy_names)
  name        = var.custom_policy_names[count.index]
  policy      = var.custom_policy_contents[count.index]
}

resource "aws_iam_policy_attachment" "iam_custom_policy_attachment" {
  name        = "custom-policy-attachment-${var.custom_policy_names[count.index]}"
  count       = length(var.custom_policy_names)
  roles       = [aws_iam_role.iam_role.name]
  policy_arn  = aws_iam_policy.iam_policy[count.index].arn
}

resource "aws_iam_policy_attachment" "iam_system_policy_attachment" {
  name       = "system-policy-attachment-${var.system_policy_names[count.index]}"
  count      = length(var.system_policy_names)
  roles      = [aws_iam_role.iam_role.name]
  policy_arn = "var.use_service_role_arn ? "arn:aws:iam::aws:policy/service-role/${var.system_policy_names[count.index]}" : "arn:aws:iam::aws:policy/${var.system_policy_names[count.index]}"
}


