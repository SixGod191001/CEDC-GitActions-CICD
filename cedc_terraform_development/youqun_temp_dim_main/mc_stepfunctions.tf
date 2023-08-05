module "state_machine" {
  source            = "../../cedc_terraform_generic_modules/modules/step_functions"
  state_machine_name = cicd-workflow-state-machine"
  role_name          = "step_functions_execute_role"
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
  dependencies       = ["cedc_terraform_development/cedc_step_functions_iam_common"]
}

module "lambda_script" {
  source = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "scriptbucket"
  scripts_name  = "cicd-lambda-scprit.zip"
  scripts_path = "${path.module}/cicd-lambda-scprit.zip"
}

module "lambdavic" {
  source = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name = "cicd-workflow-lambda"
  role_name = "lambda_execute_role"
  handler = "lambda_function.lambda_handler"
  runtime = "python3.9"
  s3_bucket = "gitaction-s3-terraform"
  s3_key = "cicd-lambda-scprit.zip"
  dependencies = ["cedc_terraform_development/lyw_cedc_lambda_iam_common","state_machine"]
}
