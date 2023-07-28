#data "aws_s3_bucket" "glue_scripts_bucket" {
#  bucket = var.scripts_bucket_location
#  region = var.scripts_bucket_region
#}

resource "aws_s3_bucket_object" "glue_script" {
  bucket = var.scripts_bucket_name
  key    = var.scripts_bucket_location
  source = var.scripts_path
}