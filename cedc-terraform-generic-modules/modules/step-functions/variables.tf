variable "state_machine_name" {
  description = "The name of the state machine"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role"
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

variable "depends_on" {
  description = "A list of resources that the state machine depends on"
  type        = list(string)
}