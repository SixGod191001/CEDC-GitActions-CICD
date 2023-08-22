variable "name" {
  description = "The dataset name must contain 1-255 characters. Valid characters are alphanumeric (A-Z, a-z, 0-9), hyphen (-), period (.), and space."
  type        = string
}

variable "dependencies" {
  description = "Cross folder module dependencies"
  type    = list(string)
  default = []
}

variable "bucket" {
  description = "the name of s3 bucket"
  type        = string
}

variable "key" {
  description = "the name of s3 bucket folder"
  type        = string
}

variable "delimiter" {
  description = "csv format"
  type        = string
  default     = ","
}

variable "header_row" {
  description = "csv format header row"
  type        = string
  default     = true
}
