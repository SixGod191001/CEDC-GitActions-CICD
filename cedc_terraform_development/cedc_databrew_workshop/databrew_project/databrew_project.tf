module "databrew_project1" {
  source       = "../../../cedc_terraform_generic_modules/modules/databrew_project"
  name         = "youqun project"
  dataset_name = "youqun-sales"
  role_name    = "youqun_databrew_common_role"
  recipe_name  = "youqun recipe"
}

module "example_recipe1" {
  source           = "../../../cedc_terraform_generic_modules/modules/databrew_recipe"
  recipe_name      = "youqun recipe"
}