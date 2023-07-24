# -*- coding: utf-8 -*-
"""
@Author : YANG YANG
@Date : 2023/7/23 14:52
"""
string = "/home/ubuntu/cedc_terraform_development/cedc_step_functions_example/step_functions"
new_string = "./" + string.split("cedc_terraform_development/")[1]
print(new_string)
