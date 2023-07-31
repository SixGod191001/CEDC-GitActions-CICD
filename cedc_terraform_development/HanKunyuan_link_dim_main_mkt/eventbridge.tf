module "cloudwatch_event_rule" {
  source          = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  name            = "cedc-eventbridge-trigger-lambda"
  
  role_name       = "event_bridge_execute_role"
  event_rule_name ="schedule_rate"
  schedule_expression_details = "rate(1 hour)"
  event_enabled   ="enabled"
}
