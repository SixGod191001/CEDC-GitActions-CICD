module "lambdavic" {
  source       = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name   =  "lyw_labdavic"
  role_name = "lambda_execute_role"
  handler       = "main.handler"
  runtime       = "python3.8"
 }

