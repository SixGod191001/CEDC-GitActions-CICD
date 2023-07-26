data "aws_s3_bucket" "glue_scripts_bucket" {
  bucket = var.scripts_bucket_location
}

resource "aws_s3_bucket_object" "glue_script" {
  bucket = data.aws_s3_bucket.glue_scripts_bucket.id
  key    = var.scripts_name
  source = var.scripts_path
}