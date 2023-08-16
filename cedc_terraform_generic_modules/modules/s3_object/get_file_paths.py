import os
import sys
import json


def get_file_paths(folder_paths, keys):
    """
    :param folder_paths: folder or object path
    :return: map string of json format
    """
    file_paths_dict = {}
    for idx, folder_path in enumerate(folder_paths):
        parent_folder = extract_name(folder_path)
        if os.path.isdir(folder_path):
            for root, dirs, files in os.walk(folder_path):
                for file in files:
                    key = setup_keys(keys, idx, str(os.path.join(root, file))[int(parent_folder):])
                    file_paths_dict[key] = os.path.join(root, file)

        else:
            key = setup_keys(keys, idx, parent_folder)
            file_paths_dict[key] = folder_path

    file_paths_json = json.dumps(file_paths_dict)

    return file_paths_json


def extract_name(path):
    """
    :param path:
    :return: 如果是folder返回index,如果是对象返回对象名字
    """
    # 判断路径是否指向文件夹
    if os.path.isdir(path):
        # 提取文件夹名字
        folder_name = os.path.basename(os.path.normpath(path))
        # 获取文件夹名字在路径中的起始索引
        index = path.index(folder_name)
        return index
    # 判断路径是否指向文件
    else:
        # 提取文件名字
        file_name = os.path.basename(path)
        return file_name


def setup_keys(keys, current_idx, self_key):
    """
    :param keys: 用户自定义的Key的list
    :param self_key: 对象或者文件夹对应的自己的key
    :return: 返回key
    """
    if len(keys) == 0:
        # 用自带名称作为key
        return self_key
    elif len(keys) == 1:
        # 将多个文件或者文件夹上传到统一的s3路径下
        return keys[0] + "/" + self_key
    elif len(keys) == len(folder_paths) and len(keys) != 0:
        # 一对一上传文件到对应s3路径下
        return keys[current_idx] + "/" + self_key
    else:
        raise KeyError


if __name__ == "__main__":
    folder_paths = sys.argv[1].split(";")
    if len(sys.argv[2]) is None:
        keys = []
    else:
        keys = sys.argv[2].split(";")

    file_paths_json = get_file_paths(folder_paths, keys)
    print(file_paths_json)
