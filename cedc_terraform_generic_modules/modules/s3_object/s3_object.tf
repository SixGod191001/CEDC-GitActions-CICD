data "aws_ssm_parameter" "ssm_param" {
  name     = var.s3_bucket_name
}

data "local_file" "objects" {
  count    = length(var.files)
  filename = element(var.files, count.index)
}

resource "aws_s3_object" "s3_objects" {
  for_each = data.local_file.objects
  bucket   = data.aws_ssm_parameter.ssm_param.value
  key      = var.key
  source   = each.value
}
