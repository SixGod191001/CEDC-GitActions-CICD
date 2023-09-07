module "databrew_project" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_project"
  name         = "kunyuan-project"
  dataset_name = "kunyuan-sales"
  role_name    = "kunyuan_databrew_common_role"
  recipe_name  = "kunyuan-recipe"
}
