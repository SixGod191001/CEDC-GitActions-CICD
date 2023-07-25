module "aws_glue_database"{
  source = "../../../cedc_terraform_generic_modules/modules/glue_database"
  glue_database_name = cedc_glue_database0724
}