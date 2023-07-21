data "terraform_remote_state" "step_functions_iam_role" {
  backend = "s3"

  config = {
    bucket         = var.bucket
    key            = var.key
    region         = var.region
  }
}

module "state_machine" {
  source            = "../../../cedc-terraform-generic-modules/modules/step-functions"
  state_machine_name = "aws_sfn_state_machine"
  role_arn          = data.terraform_remote_state.step_functions_iam_role.outputs.iam_role_arn
  definition        = file("${path.module}/state_machine_definition.json")
  tags              = { "project" = "CEDC" }
}