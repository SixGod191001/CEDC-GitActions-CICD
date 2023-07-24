module "state_machine" {
  source          = "../../cedc-terraform-generic-modules/modules/eventbridge"
  eventbridgename = "cedc-eventbridge-trigger-lambda-xy"
  role_arn        = aws_iam_role.eventbridge_execute_role.arn
  description     = "input sfn name to Trigger Lambda every five minutes"
  schedule_expression = "rate(5 minutes)"
  event_pattern   = <<EOF
                    {
                      "detail": {
                        "state_machine_name": ["cedc-sm-workflow-glue-job-xy"]
                      }
                    }
                    EOF
}