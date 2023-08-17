terraform {
  required_providers {
    awscc = {}
    aws = {}
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}



provider "awscc" {
  region = var.region
}