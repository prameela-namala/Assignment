

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0" # Terraform AWS provider version
    }
  }

  backend "s3" {
    bucket  = "prami-assignment" # Replace with your unique bucket name
    key     = "roboshop"
    region  = "us-east-1"
    encrypt = true
    use_lockfile   = true
  }
}

provider "aws" {
  region = var.region
}