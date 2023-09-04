module "databrew_project1" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_project"
  name         = "elaine-project"
  dataset_name = "elaine-sales"
  role_name    = "elaine_databrew_common_role"
  recipe_name  = "elaine-recipe"
}