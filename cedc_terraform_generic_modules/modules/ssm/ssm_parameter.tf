resource "aws_ssm_parameter" "ssm_parameter" {
  name             = var.name
  type             = var.type
  allowed_pattern  = var.allowed_pattern
  data_type        = var.data_type
  description      = var.description
  insecure_value   = var.insecure_value
  key_id           = var.key_id
  tags             = var.tags
  tier             = var.tier
  value            = var.value
}