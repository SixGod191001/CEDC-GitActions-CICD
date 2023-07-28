variable "scripts_bucket_location" {
  description = "The location of the script bucket"
  type = string
}

variable "scripts_bucket_name" {
  description = "your-script-bucket-name"
  type = string
}

#variable "scripts_bucket_region" {
#  description = "The region of the script bucket"
#  type = string
#}

#variable "scripts_name" {
#  description = "your-script-name"
#  type = string
#}

variable "scripts_path" {
  description = "path/to/your/script.py"
  type = string
}