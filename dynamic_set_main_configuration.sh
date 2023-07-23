# 获取符合条件的所有 .tf 文件的父级目录路径
directories=$(find ./cedc_terraform_development -type f -name '*.tf' -exec dirname {} \; | sort -u)

# 生成 Terraform 配置文件
cat << EOF > main.tf
variable "subdirectories" {
  type    = list(string)
  default = [ $(echo "$directories" | awk '{print " \""$0"\","}' | sed '$s/,$//') ]
}

$(for dir in $directories; do
  module_name=$(echo "$dir" | sed -e 's/[^a-zA-Z0-9]/_/g' -e 's/^.*\///')
  module_name=$(echo "$module_name" | sed 's/^__//')
  dependencies=''

  # 解析dir路径里的所有.tf文件
  tf_files=$(find "$dir" -maxdepth 1 -type f -name '*.tf')

  # 判断每个文件里是否有 variable "dependencies"
  for tf_file in $tf_files; do
    if grep -q 'variable "dependencies"' "$tf_file"; then
      # 获取 default 后边的 [] 数组内容
      file_dependencies=$(sed -n 's/.*default *= *\[\([^]]*\)\]/\1/p' "$tf_file" | tr -d '," ')
      dependencies+=$file_dependencies
      dependencies+=","
    fi
  done


  echo "module \"${module_name}\" {"
  echo "  source = \"${dir}\""
  if [ ${#dependencies} -gt 0 ]; then
    # 替换除了英文数字逗号的其他所有字符为_
    dependencies=$(echo "$dependencies" | sed 's/[^a-zA-Z0-9,]/_/g')

    # 如果字符串末尾有逗号，则删除
    dependencies=$(echo "$dependencies" | sed 's/,$//')

    # 将字符串以逗号分割为数组
    IFS=',' read -ra arr <<< "$dependencies"

    # 删除每个元素开头的所有下划线
    for i in "${!arr[@]}"; do
      arr[$i]="${arr[$i]#*_}"
    done

    # 将数组元素以逗号拼接成字符串
    dependencies=$(IFS=','; echo "${arr[*]}")
    echo "  depends_on = [${dependencies}]"
  fi
  echo "}"
done)
EOF

# 打印生成的文件内容
cat main.tf