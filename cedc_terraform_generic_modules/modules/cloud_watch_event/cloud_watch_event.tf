data "aws_iam_role" "cloudwatch_event_role" {
  name = var.role_name
}

resource "aws_cloudwatch_event_rule" "event_rule" {
  name                  = var.event_rule_name
  schedule_expression   = var.schedule_expression_details      # Trigger time (frequency/specific time)
# event_pattern         = event_pattern_details                # Trigger condition
  is_enabled            = var.event_enabled                    # Set the default value in the variable to "true"
  role_arn              = data.aws_iam_role.cloudwatch_event_role.arn      
}
