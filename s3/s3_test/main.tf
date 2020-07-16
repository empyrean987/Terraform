module "s3_bucket" {
#  source              = "./modules"
  source              = "git::git@github.com:empyrean987/Terraform.git//s3/s3_test/modules?ref=v0.0.12"
  bucket              = var.bucket
}

#variable "bucket" {}