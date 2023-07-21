variable "subdirectories" {
  type    = list(string)
  default = [
 "./cedc-terraform-development/YangYang-Fact-xxx/step-functions",
 "./cedc-terraform-development/iam-step-functions"
  ]
}

module "__cedc_terraform_development_iam_step_functions" {
  source = "./cedc-terraform-development/iam-step-functions"
  bucket = var.bucket
  key    = var.key
  region = var.region
}

# module "__cedc_terraform_development_YangYang_Fact_xxx_step_functions" {
#   source = "./cedc-terraform-development/YangYang-Fact-xxx/step-functions"
#   bucket = var.bucket
#   key    = var.key
#   region = var.region
# }
