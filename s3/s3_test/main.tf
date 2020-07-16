module "s3_bucket" {
  source              = "./modules"
  bucket              = var.bucket
}

variable "bucket" {}