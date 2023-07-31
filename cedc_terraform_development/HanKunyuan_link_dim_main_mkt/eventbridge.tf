module "cloudwatch_event_rule" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  name            = "eventbridge-trigger-lambda"
  role_name       = "event_bridge_execute_role"
  schedule_expression = "rate(1 hour)"
}
