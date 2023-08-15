data "aws_ssm_parameter" "ssm_param" {
  name = var.s3_bucket_name
}

data "local_file" "objects" {
  count    = length(var.files)
  filename = element(var.files, count.index)
}

locals {
  file_paths = flatten([
    for file in data.local_file.objects : (
      fileset(file, "**/*")  # 递归获取文件夹下的所有文件路径
    )
  ])
}

resource "aws_s3_object" "s3_objects" {
  for_each = { for idx, file in local.file_paths : idx => file }

  bucket   = data.aws_ssm_parameter.ssm_param.value
  key      = var.key
  source   = each.value
}