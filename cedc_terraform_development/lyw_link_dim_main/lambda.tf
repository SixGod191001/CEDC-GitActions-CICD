module "lambda_script" {
  source = "../../cedc_terraform_generic_modules/modules/s3_object"
  scripts_bucket_name = "gitaction-s3-terraform"
  scripts_name  = "upload_S3_file.zip"
  scripts_path = "${path.module}/upload_S3_file.zip"
  }

