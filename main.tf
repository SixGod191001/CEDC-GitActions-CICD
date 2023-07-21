variable "subdirectories" {}

module "development" {
  for_each = toset(var.subdirectories)

  source = each.value
}