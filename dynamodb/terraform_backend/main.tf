resource "aws_dynamodb_table" "terraform_backend" {
    name = "terraform_backend"
    read_capacity = "50"
    write_capacity = "50"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
    }
}