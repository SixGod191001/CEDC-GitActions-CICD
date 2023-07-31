data "aws_iam_role" "cloudwatch_event_role" {
  name = var.role_name
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                  = var.event_rule_name
  schedule_expression   =var.schedule_expression_details

  role_arn   = data.aws_iam_role.cloudwatch_event_role.arn
}


