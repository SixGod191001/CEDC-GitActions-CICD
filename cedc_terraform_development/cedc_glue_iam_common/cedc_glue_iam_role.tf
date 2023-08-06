module "step_functions_iam_role" {
  source          = "../../cedc_terraform_generic_modules/modules/iam"
  role_name       = "glue_execute_role"
  assume_role_policy = file("${path.module}/trust_policy.json")
  policy_names    = ["glue_invoke_s3_policy"]
  policy_contents = [file("${path.module}/glue_invoke_s3_policy.json")]
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "my-policy-attachment"   # 示例：将 [Name for the policy attachment] 替换为 "my-policy-attachment"
  roles      = [module.step_functions_iam_role.role_id]
  policy_arn = "[arn:aws:iam::aws:policy/AmazonS3FullAccess]"
}

# 确保政策附加在 IAM 角色之前被创建和附加
resource "aws_iam_policy_attachment" "policy_attachment" {
  depends_on = [module.step_functions_iam_role]
}
