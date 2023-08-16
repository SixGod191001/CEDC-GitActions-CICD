import os
import sys
import json

def get_file_paths(folder_paths):
    file_paths = []
    for folder_path in folder_paths:
        for root, dirs, files in os.walk(folder_path):
            for file in files:
                file_paths.append(os.path.join(root, file))
    return file_paths

if __name__ == "__main__":
    folder_paths = sys.argv[1].split(";")
    file_paths = get_file_paths(folder_paths)
    file_paths_dict = {str(idx): path for idx, path in enumerate(file_paths)}
    file_paths_json = json.dumps(file_paths_dict)
    print(file_paths_json)
