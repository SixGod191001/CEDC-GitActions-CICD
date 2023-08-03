#创建eventbridge
module "cloudwatch_event_rule" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  schedule_expression_details = "rate(1 minute)"
  role_name                   = "eventbridge_invoke_lambda_execute_role"
  dependencies                = ["cedc_terraform_development/cedc_eventbridge_iam_common"]
}


# 在target lambda中设置 来自 AWS 事件服务的调用才能调用 Lambda 函数的permission
module "lambda_add_permission" {
  source                      = "../../cedc_terraform_generic_modules/modules/lambda_permissions"
  permission_statement_id     = "lambda_add_permission"
  lambda_function_name        = "Test"
  execution_arn               = "arn:aws:events:ap-northeast-1:213903534337:rule/cedc-eventbridge-trigger-lambda"   #eventbridge的arn
  depends_on                  = [module.cloudwatch_event_rule]
}


# 添加eventbridge的目标
module "cloudwatch_event_rule_target" {
  source                      = "../../cedc_terraform_generic_modules/modules/cloud_watch_event_target"
  event_rule_name             = "cedc-eventbridge-trigger-lambda"
  target_id                   = "Test"
  arn_details                 = "arn:aws:lambda:ap-northeast-1:213903534337:function:Test"
  depends_on                  = [module.lambda_add_permission]          # 依赖target lambda 已经设置permission
}
