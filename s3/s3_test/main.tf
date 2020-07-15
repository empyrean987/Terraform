resource "aws_s3_bucket" "s3_bucket" {
  acl    = "private"
  bucket = var.bucket
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
}
