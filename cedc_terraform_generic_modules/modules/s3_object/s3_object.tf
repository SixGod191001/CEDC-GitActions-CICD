data "aws_ssm_parameter" "ssm_param" {
  name = var.s3_bucket_name
}

locals {
  file_paths = flatten([
    for file in var.files : (
      fileset(pathexpand(file), "**")  # 使用绝对路径获取文件夹下的所有文件路径
    )
  ])
}

resource "aws_s3_object" "s3_objects" {
  for_each = { for idx, file in local.file_paths : idx => file }
  bucket   = data.aws_ssm_parameter.ssm_param.value
  key      = each.value
  source   = each.value
}