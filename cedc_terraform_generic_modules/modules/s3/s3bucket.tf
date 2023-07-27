resource "aws_s3_bucket" "example_bucket" {
  name        = var.bucket_name
  region      = var.region
  acl         = var.acl
  tag         = var.tag
}
