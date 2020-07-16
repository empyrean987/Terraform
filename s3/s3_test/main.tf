module "s3_test_bucket" {
  source              = "../local_module/app"
  bucket              = var.bucket
}