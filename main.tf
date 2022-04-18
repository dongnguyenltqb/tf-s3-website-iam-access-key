terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"
    }
  }
}

variable "aws_az_name" {
  type = string
}

provider "aws" {
  region = var.aws_az_name
}

output "aws_zone" {
  value = var.aws_az_name
}
