resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = var.permission_statement_id  
  action        = "lambda:InvokeFunction"      
  function_name = var.lambda_function_name     #target lambda
  principal     = "events.amazonaws.com"       #表示只有来自 AWS 事件服务的调用才能调用 Lambda 函数

  source_arn = var.execution_arn               #调用target lambda的eventbridge的arn
}
