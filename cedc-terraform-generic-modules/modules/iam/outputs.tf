utput "gitactions_eventbridge_role_arn" {
  value = aws_iam_role.gitactions_eventbridge_role.arn
}

output "gitactions_lambda_execution_policy_arn" {
  value = aws_iam_policy.gitactions_lambda_execution_policy.arn
}