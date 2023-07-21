variable "subdirectories" {}

module "development" {
  count = length(var.subdirectories)

  for_each = toset(var.subdirectories)
  source = each.value



  name = replace(key(each.value), "/", "_")
}