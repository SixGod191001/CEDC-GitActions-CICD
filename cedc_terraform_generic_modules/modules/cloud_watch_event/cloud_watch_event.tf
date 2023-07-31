data "aws_iam_role" "cloudwatch_event_role" {
  name = var.role_name
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name       = var.name
  schedule_expression = var.schedule_expression
  role_arn   = data.aws_iam_role.cloudwatch_event_role.arn
}

