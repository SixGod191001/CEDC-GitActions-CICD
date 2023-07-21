bash
#!/bin/bash

# 获取所有符合模糊匹配的子目录
subdirectories=$(find ./cedc-terraform-development -type d -name '*' -printf '%P\n')

# 生成 Terraform 配置文件
cat << EOF > main.tf
variable "subdirectories" {
  type    = list(string)
  default = [$(echo $subdirectories | sed -e 's/ /, /g')]
}

module "development" {
  source = "\${var.subdirectories[count.index]}"
  count  = length(var.subdirectories)
}
EOF

# 打印生成的文件内容
cat main.tf