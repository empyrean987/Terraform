resource "aws_s3_bucket" "terraform_backend" {
  acl    = "private"
  bucket = "test"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
}
