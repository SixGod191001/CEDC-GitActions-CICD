module "lambdavic" {
  source       = "../../cedc_terraform_generic_modules/modules/lambda"
  function_name   =  "lyw_labdavic"
  role_name = "lambda_to_stepfunctions_execute_role0001"
  handler       = "main.handler"
  runtime       = "python3.8"
 }

module "upload_file" {
  source = "../../cedc_terraform_generic_modules/modules/s3_object"
  file_bucket_name = "gitaction-s3-terraform"
  file_bucket_location = "upload S3 file.py"
  file_path = "${path.module}/upload S3 file.py"
}
