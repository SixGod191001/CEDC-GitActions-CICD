resource "aws_ssm_parameter" "foo" {
    name = "foo"
    type = "String"
    value = "changedOnFeature5"
}

module sf {
  source  = "gitlab.com/cedc-terraform-development/applications/regional/landing"
  description = "Simple data module for getting current external IP address"
  version = "1.0.0"
}