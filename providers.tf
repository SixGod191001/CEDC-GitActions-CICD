terraform {
  backend "s3" {}
}

provider "aws" {
  region = "ap-northeast1"
}