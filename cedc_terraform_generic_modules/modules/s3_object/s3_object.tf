resource "aws_s3_bucket_object" "glue_script" {
  bucket = var.scripts_bucket_name
  key    = var.scripts_bucket_location
  source = var.scripts_path
}
