provider "aws" {
  access_key = "AKIATDTNE5EAZYPBXZGS"
  secret_access_key = "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"
  region = "ap-northeast-1"
}

# 引用现有的IAM角色，该角色允许跨账号访问B账号
data "aws_iam_role" "cross_account_role" {
  name = "glue-execute"
}

# 创建IAM策略，授予跨账号角色访问B账号S3的权限
resource "aws_iam_policy" "s3_access_policy" {
  name   = "S3AccessPolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "S3Access",
      "Effect": "Allow",
      "Action": [
         "s3:GetObject",
         "s3:PutObject"
      ],
      "Resource": [
            "arn:aws:s3:::cicddevraw/*",
            "arn:aws:s3:::cicddevraw",
            "arn:aws:s3:::cicddevtarget/*",
            "arn:aws:s3:::cicddevtarget",
      ]
    }
  ]
}
EOF
}

# 将策略附加到现有角色
resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = data.aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}