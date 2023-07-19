variable "name" {
  type    = string
  default = module.example_step_functions.name
  description = "The name of the Step Functions state machine"

}

variable "definition" {
  type        = string
  description = "The definition of the Step Functions state machine"
  default = module.example_step_functions.definition
}

variable "tags" {
  type        = map(string)
  description = "The tags to apply to the Step Functions state machine"
  default = module.example_step_functions.tags
}