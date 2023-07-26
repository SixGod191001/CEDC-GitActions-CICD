variable "bucket_name" {
  description = "The name of the s3bucket"
  type = string
}

variable "region" {
  description = "The region of the s3bucket"
  type = string
}

variable "acl" {
  description = "The acl of the s3bucket"
  type = string
}

variable "tag" {
  description = "The tag of the s3bucket"
  type = string
}
