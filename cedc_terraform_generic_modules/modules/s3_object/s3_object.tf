data "aws_ssm_parameter" "ssm_param" {
  name = var.s3_bucket_name
}

data "external" "file_paths" {
  program = ["python", "${path.module}/get_file_paths.py", join(";", var.files)]
}

resource "aws_s3_object" "s3_objects" {
  for_each = { for idx, file in jsondecode(data.external.file_paths.result) : idx => file }
  bucket   = data.aws_ssm_parameter.ssm_param.value
  key      = each.value
  source   = each.value
}