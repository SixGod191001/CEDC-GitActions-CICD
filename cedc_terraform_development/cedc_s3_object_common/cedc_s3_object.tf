module "upload_s3_object" {
  source          = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name       = "scriptbucket"
  scripts_bucket_location ="${path.module}/test1.py"
  scripts_path ="test1.py"
}
