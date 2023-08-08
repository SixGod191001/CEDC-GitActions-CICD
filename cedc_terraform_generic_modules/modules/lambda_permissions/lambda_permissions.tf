# Get the ssm parameters_account
data "aws_ssm_parameter" "Account" {
  name = "ETL_Account"
}

# Get the ssm parameters_region
data "aws_ssm_parameter" "Region" {
  name = "ETL_Region"
}

locals {
event_rule_arn = format("arn:aws:events:%s:%s:rule/%s", data.aws_ssm_parameter.Region.value, data.aws_ssm_parameter.Account.value, var.event_rule_name)
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id   = var.permission_statement_id
  action         = "lambda:InvokeFunction"
  function_name  = var.lambda_function_name
  principal      = "events.amazonaws.com"
  source_arn     = local.event_rule_arn
}
