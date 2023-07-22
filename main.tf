variable "subdirectories" {
  type    = list(string)
  default = [
 "./cedc_terraform_development/cedc_step_functions_example/step_functions",
 "./cedc_terraform_development/cedc_step_functions_iam_common"
  ]
}

module "cedc_terraform_development_cedc_step_functions_iam_common" {
  source = "./cedc_terraform_development/cedc_step_functions_iam_common"
}

module "cedc_terraform_development_cedc_step_functions_example_step_functions" {
  source = "./cedc_terraform_development/cedc_step_functions_example/step_functions"
}
