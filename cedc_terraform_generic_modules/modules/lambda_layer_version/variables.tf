variable "filename" {
  description = "layer file filename with path"
  type = string
}

variable "layer_name" {
  description = "The name of the lambda layer"
  type = string
}


variable "compatible_runtimes" {
  description = "The name of the lambda layer runtimes"
  type    = list(string)
  default = []
}

variable "source_code_hash" {
  description = "The code of layer"
  type = string
}
 



