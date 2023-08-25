module "global_config_cedc_feature_terraform_backend_bucket" {
  source = "../../cedc_terraform_generic_modules/modules/ssm"

  name        = "cedc_feature_terraform_backend_bucket"
  type        = "String"
  value       = "gitaction-s3-terraform"
  description = "Store states file for git actions"
  tags        = {
    environment = "feature"
    project     = "cedc"
  }
}

module "global_config_cedc_feature_region" {
  source = "../../cedc_terraform_generic_modules/modules/ssm"

  name        = "cedc_feature_region"
  type        = "String"
  value       = "ap-northeast-1"
  description = "Store one region for project cedc"
  tags        = {
    environment = "feature"
    project     = "cedc"
  }
}

module "global_config_cedc_feature_account" {
  source = "../../cedc_terraform_generic_modules/modules/ssm"

  name        = "cedc_feature_account"
  type        = "String"
  value       = "213903534337"
  description = "Store one account number not only for current account you can define any other account for the same, this one just for demo"
  tags        = {
    environment = "feature"
    project     = "cedc"
  }
}

#module "global_config_cedc_dev_env" {
#  source = "../../cedc_terraform_generic_modules/modules/ssm"
#
#  name        = "terraform_backend_bucket"
#  type        = "String"
#  value       = "gitaction-s3-terraform"
#  description = "Store states file for git actions"
#  tags        = {
#    environment = "dev"
#    project     = "cedc"
#  }
#}
#
#module "global_config_cedc_uat_env" {
#  source = "../../cedc_terraform_generic_modules/modules/ssm"
#
#  name        = "terraform_backend_bucket"
#  type        = "String"
#  value       = "gitaction-s3-terraform"
#  description = "Store states file for git actions"
#  tags        = {
#    environment = "uat"
#    project     = "cedc"
#  }
#}
#
#module "global_config_cedc_prod_env" {
#  source = "../../cedc_terraform_generic_modules/modules/ssm"
#
#  name        = "terraform_backend_bucket"
#  type        = "String"
#  value       = "gitaction-s3-terraform"
#  description = "Store states file for git actions"
#  tags        = {
#    environment = "prod"
#    project     = "cedc"
#  }
#}