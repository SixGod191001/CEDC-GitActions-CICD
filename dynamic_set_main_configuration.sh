##!/bin/bash
#
## 获取符合条件的所有 .tf 文件的父级目录路径
#directories=$(find ./cedc-terraform-development -type f -name '*.tf' -exec dirname {} \; | sort -u)
#
## 生成 Terraform 配置文件
#cat << EOF > main.tf
#variable "subdirectories" {
#  type    = list(string)
#  default = [
#$(echo "$directories" | awk '{print " \""$0"\","}' | sed '$s/,$//')
#  ]
#}
#
#
#$(for dir in $directories; do
#    module_name=$(echo "$dir" | sed -e 's/[^a-zA-Z0-9]/_/g' -e 's/^.*\///')
#    module_name=$(echo "$module_name" | sed 's/^__//')
#    echo "module \"${module_name}\" {"
#    echo "  source = \"${dir}\""
#    echo "}"
#done)
#EOF
#
## 打印生成的文件内容
#cat main.tf