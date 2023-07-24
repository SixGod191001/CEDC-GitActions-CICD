variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy"{
  description = "trust policy"
  type        = string
}


variable "policy_names" {
  description = "A list of policy names"
  type        = list(string)
}

variable "policy_contents" {
  description = "A list of policy contents"
  type        = list(string)
}