resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = var.permission_statement_id
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"

  source_arn = var.execution_arn
}
