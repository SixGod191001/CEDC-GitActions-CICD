locals {
  module_directories = fileset(path.cwd, "cedc-terraform-development/*/")
}

module "development" {
  source = "./cedc-terraform-development"
  for_each = local.module_directories
  name = each.key
}