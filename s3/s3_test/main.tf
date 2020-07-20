provider "aws" {
  region = var.region
  # ... other provider settings ...
}

module "s3_bucket" {
  source              = "./modules/s3_bucket"
#  source              = "git::git@github.com:empyrean987/Terraform.git//s3/s3_test/modules/s3_bucket?ref=v0.0.17"
  bucket              = var.bucket
}

region = "region" {}
variable "bucket" {}
