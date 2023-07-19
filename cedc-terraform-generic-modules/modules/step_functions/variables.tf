variable "name" {
  type        = string
  description = "The name of the Step Functions state machine"
}

variable "definition" {
  type        = string
  description = "The definition of the Step Functions state machine"
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the Step Functions state machine"
}