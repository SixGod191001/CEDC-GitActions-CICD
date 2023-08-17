terraform {
  required_providers {
    awscc = {
      source = "hashicorp/awscc"
      version = "0.58.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.12.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.region
}



provider "awscc" {
  region = var.region
}