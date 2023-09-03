variable "name" {
  description = "project name (required)"
  type        = string
}

variable "role_arn" {
  description = "Role arn (required)"
  type        = string
}

variable "dataset_name" {
  description = "dataset name (required)"
  type        = string
}

variable "recipe_name" {
  description = "recipe name (required)"
  type        = string
}
