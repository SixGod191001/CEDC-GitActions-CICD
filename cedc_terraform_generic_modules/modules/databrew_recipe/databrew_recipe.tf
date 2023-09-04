resource "aws_databrew_recipe" "example_recipe" {
  name         = var.recipe_name
  recipe_steps = file("../../../cedc_terraform_development/cedc_databrew_workshop/databrew_project/recipe.json")
}