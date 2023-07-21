#!/bin/bash

# 获取符合条件的所有 .tf 文件的父级目录路径
directories=$(find ./cedc-terraform-development -type f -name '*.tf' -exec dirname {} \; | sort -u)

# 将路径转换为字符串形式
directories_string=$(echo "$directories" | awk '{printf "\"%s\", ", $0}' | sed 's/, $//')

# 生成 Terraform 配置文件
cat << EOF > main.tf
variable "subdirectories" {
  type    = list(string)
  default = [$directories_string]
}

module "development" {
  source = "\${var.subdirectories[count.index]}"
  count  = length(var.subdirectories)
}
EOF

# 打印生成的文件内容
cat main.tf