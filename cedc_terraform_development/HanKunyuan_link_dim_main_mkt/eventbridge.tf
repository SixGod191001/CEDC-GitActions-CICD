


module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = "TEST"
  target_id                   = "Test"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"
 # depends_on                  = [module.cloudwatch_event_rule]
}

