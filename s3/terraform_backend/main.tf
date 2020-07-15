resource "aws_s3_bucket" "terraform_backend" {
  acl    = "private"
  bucket = "terraform_backend"
  lifecycle {
    prevent_destroy = true
  }
  versioning {
    enabled = true
  }
}