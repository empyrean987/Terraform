module "s3_test_bucket" {
  source              = "./local_module"
  bucket              = var.bucket
}