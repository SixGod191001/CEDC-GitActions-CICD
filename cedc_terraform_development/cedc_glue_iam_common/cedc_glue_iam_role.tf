module "step_functions_iam_role" {
  source                 = "../../cedc_terraform_generic_modules/modules/iam"
  role_name              = "liuzhu_glue_execute_role"
  trust_policy           = file("${path.module}/trust_policy.json")
  system_policy_names    = ["CloudSearchFullAccess"]
  custom_policy_names    = ["liuzhu_glue_invoke_s3_policy","liuzhu_s3_full_policy","liuzhu_glue_catalog_access","liuzhu_glue_service_policy"]
  custom_policy_contents = [file("${path.module}/glue_invoke_s3_policy.json"),
                    file("${path.module}/s3_full_policy.json"),
                    file("${path.module}/s3_full_policy.json"),
                    file("${path.module}/glue_service_policy.json")]
}
