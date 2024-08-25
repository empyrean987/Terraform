resource "aws_s3_bucket" "s3_bucket" {
	acl    = "private"
	bucket = var.bucket
	lifecycle {
		prevent_destroy = false
	}
	versioning {
		enabled = true
	}
}