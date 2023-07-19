resource "aws_iam_role" "gitactions_eventbridge_role" {
  name = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "gitactions_stepfunctions_policy" {
  name        = "gitactions-stepfunctions-policy"
  description = "Policy for EventBridge to invoke Step Functions"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "EventBridgeInvokeStepFunctions",
      "Effect": "Allow",
      "Action": "states:StartExecution",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "gitactions_eventbridge_role_attachment" {
  role       = aws_iam_role.gitactions_eventbridge_role.name
  policy_arn = aws_iam_policy.gitactions_stepfunctions_policy.arn
}