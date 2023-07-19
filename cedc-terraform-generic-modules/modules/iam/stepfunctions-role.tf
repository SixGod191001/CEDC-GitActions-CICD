resource "aws_iam_role" "stepfunctions_role" {
  name = var.name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "states.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "stepfunctions_policy" {
  name        = "stepfunctions-policy"
  description = "Policy for Step Functions"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "StepFunctionsPermissions",
      "Effect": "Allow",
      "Action": [
        "lambda:InvokeFunction"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "stepfunctions_policy_attachment" {
  role       = aws_iam_role.stepfunctions_role.name
  policy_arn = aws_iam_policy.stepfunctions_policy.arn
}