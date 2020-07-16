provider "aws" {
  region = "us-east-1"
  # ... other provider settings ...
}

module "s3_bucket" {
#  source              = "./modules"
  source              = "git::git@github.com:empyrean987/Terraform.git//s3/s3_test/modules/s3_bucket?ref=v0.0.17"
  bucket              = var.bucket
}

variable "bucket" {}