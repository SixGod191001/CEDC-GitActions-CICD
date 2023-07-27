variable "subdirectories" {
  type = list(string)
  default = ["./cedc_terraform_development/cedc_step_functions_iam_common", "./cedc_terraform_development/cicd_lambda_iam_common", "./cedc_terraform_development/cedc_step_functions_example/step_functions"]
}

module "cedc_terraform_development_cedc_step_functions_iam_common" {
 source = "./cedc_terraform_development/cedc_step_functions_iam_common"
}

module "cedc_terraform_development_cicd_lambda_iam_common" {
 source = "./cedc_terraform_development/cicd_lambda_iam_common"
}

module "cedc_terraform_development_cedc_step_functions_example_step_functions" {
 source = "./cedc_terraform_development/cedc_step_functions_example/step_functions"
 depends_on = [module.cedc_terraform_development_cedc_step_functions_iam_common]
}