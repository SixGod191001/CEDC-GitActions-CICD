bash
#!/bin/bash

# 获取符合条件的所有 .tf 文件的父级目录路径
directories=$(find ./cedc-terraform-development -type f -name '*.tf' -exec dirname {} \; | sort -u)

# 生成 Terraform 配置文件
cat << EOF > main.tf
variable "subdirectories" {
  type    = list(string)
  default = [
$(echo "$directories" | awk '{printf "    \"%s\",\n", $0}' | sed 's/,$//')
  ]
}
EOF

# 打印生成的文件内容
cat main.tf