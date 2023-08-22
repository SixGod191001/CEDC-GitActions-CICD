module "prepared_s3_objects" {
  source         = "../../../cedc_terraform_generic_modules/modules/s3_object"
  s3_bucket_name = "scriptbucket"
  keys           = ["liuzhu_databrew_workshop"]
  files          = ["${path.module}/datafiles/","${path.module}/feature-engineering/","${path.module}/profile-output/","${path.module}/recipes/","${path.module}/shared/"]
}

