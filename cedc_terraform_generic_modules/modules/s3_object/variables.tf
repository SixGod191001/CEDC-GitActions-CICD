variable "s3_bucket_name" {
  description = "s3 bucket name"
  type        = string
}

variable "files" {
  description = "Local folder or path which should be uploaded to s3"
  type        = list(string)
}

variable "keys" {
  description = "target paths list in s3 bucket, you can upload multiple folders or objects to one s3 path, or upload multiple to multiple s3 path"
  type        = list(string)
  default     = []
}

