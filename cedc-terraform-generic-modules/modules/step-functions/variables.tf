variable "state_machine_name" {
  description = "The name of the state machine"
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "definition" {
  description = "The definition of the state machine"
  type        = string
}

variable "tags" {
  description = "A map of tags for the state machine"
  type        = map(string)
}
