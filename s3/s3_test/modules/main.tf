module "s3_test_bucket" {
  source              = "./s3_bucket"
  bucket              = var.bucket
}