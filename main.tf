locals {
  subdirectories = fileset(path.cwd, "./cedc-terraform-development/*/")
}

module "development" {
  source = element(local.subdirectories, count.index)
  count  = length(local.subdirectories)
}