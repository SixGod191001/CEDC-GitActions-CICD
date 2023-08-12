module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "glue_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["glue_invoke_s3_policy","s3_full_policy","glue_catalog_access","glue_service_policy"]
  policy_contents = [file("${path.module}/glue_invoke_s3_policy.json"),
                    file("${path.module}/s3_full_policy.json"),
                    file("${path.module}/s3_full_policy.json"),
                    file("${path.module}/glue_service_policy.json)]
}
