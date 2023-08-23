import os
import re
import boto3

# 请将下面的路径替换为你想要遍历的路径
path = "./cedc_terraform_development"


def replace_match(match):
    print("process match --> {}".format(match))
    value = get_parameter_value(str(match[0]))

    if value is None:
        return match[0] + match[1]

    return value + match[1]


def get_parameter_value(parameter_name):
    # 模拟获取AWS SSM参数的值
    # 在这里替换为你的获取参数值的逻辑
    ssm_client = boto3.client('ssm')

    try:
        response = ssm_client.get_parameter(
            Name=parameter_name,
            WithDecryption=True
        )
        parameter_value = response['Parameter']['Value']
        return parameter_value
    except Exception as e:
        print("An error occurred while getting parameter {}: {}".format(parameter_name, str(e)))
        return None


def process_json_file(file_path):
    all_lines = []
    with open(file_path, 'r') as file:
        for line in file:
            if "arn:aws:s3:::" in line:
                print(file_path)
                updated_line = update_json_line(line)
                all_lines.append(updated_line)
            else:
                all_lines.append(line)

    with open(file_path, 'w') as file:
        file.writelines(all_lines)


def update_json_line(line):
    matches = re.findall(r'arn:aws:s3:::([a-zA-Z0-9.\-]+)([/*]?)[\'"]?', line)

    # 遍历处理每个匹配项
    for match in matches:
        original = match[0] + match[1]
        replacement = replace_match(match)
        line = line.replace(original, replacement)

    print("final line is {}".format(line))
    return line


def traverse_json_files(root_path):
    for root, dirs, files in os.walk(root_path):
        for file in files:
            if file.endswith('.json'):
                file_path = os.path.join(root, file)
                process_json_file(file_path)


traverse_json_files(path)
