resource "awscc_databrew_project" "databrew_project"{
  name               = var.name
  dataset_name       = var.dataset_name
  role_arn           = data.aws_iam_role.role_arn.arn
  recipe_name        = var.recipe_name
  }

data "aws_iam_role" "role_arn" {
  name = var.role_name
}
