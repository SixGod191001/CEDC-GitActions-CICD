'''
import os
import re

# 请将下面的路径替换为你想要遍历的路径
path = "./cedc_terraform_development"
target_folder_name = 'cedc_terraform_development'
mapping = {}


def find_tf_files(path):
    tf_files = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(".tf"):
                if root not in mapping.keys():
                    mapping["./" + target_folder_name + root.split(target_folder_name)[1]] = [file]
                else:
                    mapping["./" + target_folder_name + root.split(target_folder_name)[1]].append(file)
    return tf_files


def rename_path(input):
    name = re.sub(r'[^a-zA-Z0-9]', '_', input)
    name = name.strip('_')
    return name


tf_files = find_tf_files(path)

content = ''

for k, v in mapping.items():
    dependencies = []
    module_name = rename_path(k)
    content += f'module "{module_name}" {{\n'
    content += f' source = "{k}"\n'
    for i in v:
        with open(os.path.join(k, i), 'r',encoding='utf-8') as file:
            file_content = file.read()
        # 使用正则表达式匹配dependencies部分的内容
        matches = re.findall(r'dependencies\s*=\s*\[([^\]]+)\]', file_content)
        if matches:
            dependencies = matches
        else:
            print(f"Dependencies not found in the {os.path.join(k, i)}.")
    if len(dependencies) != 0:
        content += ' depends_on = [' + ', '.join(['module.{0}'.format(rename_path(element)) for element in dependencies]) + ']\n'
    content += '}\n\n'

with open('./main.tf', 'w') as file:
    file.write(content)

print(content)
print("Content written to main.tf successfully.")
'''
