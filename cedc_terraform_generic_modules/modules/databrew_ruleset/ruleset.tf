resource "awscc_databrew_ruleset" "ruleset" {
  description = var.ruleset_description
  name        = var.ruleset_name
  rules       = var.rules
  tags        = var.tags
  target_arn  = local.target_arn
}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "account_number" {
  count = var.ssm_name_for_account_number != null ? 1 : 0
  name = var.ssm_name_for_account_number
}

locals {
  account_number = var.ssm_name_for_account_number != null ? data.aws_ssm_parameter.account_number[0].value : data.aws_caller_identity.current.account_id
  target_arn     = "arn:aws:data-brew:${var.region}:${local.account_number}:dataset/${var.dataset_name}"
}

