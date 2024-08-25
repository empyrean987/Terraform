provider "aws" {
	region = var.region
}

module "s3_bucket" {
	source = "./s3_bucket"
	bucket = var.bucket
}