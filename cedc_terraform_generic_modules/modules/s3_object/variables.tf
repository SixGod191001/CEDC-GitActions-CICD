variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "key" {
  description = "The absolutely path of the object"
  type        = string
}

variable "files" {
  description = "Local folder or path which should be uploaded to s3"
  type        = list(string)
}

