variable "name" {
  description = "Name of the parameter"
  type        = string
}

variable "type" {
  description = "Type of the parameter"
  type        = string
}

variable "allowed_pattern" {
  description = "Regular expression used to validate the parameter value"
  type        = string
  default     = null
}

variable "data_type" {
  description = "Data type of the parameter"
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the parameter"
  type        = string
  default     = null
}

variable "insecure_value" {
  description = "Value of the parameter (insecure)"
  type        = string
  default     = null
}

variable "key_id" {
  description = "KMS key ID or ARN for encrypting a SecureString"
  type        = string
  default     = null
}


variable "tags" {
  description = "Map of tags to assign to the object"
  type        = map(string)
  default     = {}
}

variable "tier" {
  description = "Parameter tier to assign to the parameter"
  type        = string
  default     = null
}

variable "value" {
  description = "Value of the parameter"
  type        = string
  default     = null
}