data "aws_s3_bucket" "glue_scripts_bucket" {
  bucket = var.scripts_bucket_location
  region = var.scripts_bucket_region
  name = var.scripts_bucket_name
}

resource "aws_s3_bucket_object" "glue_script" {
  bucket = data.aws_s3_bucket.glue_scripts_bucket.name
  key    = data.aws_s3_bucket.glue_scripts_bucket.bucket
  source = var.scripts_path
}