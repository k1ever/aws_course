resource "aws_dynamodb_table" "dynamodb_table_students" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = "1"
  write_capacity = "1"
  hash_key = "id"

  attribute {
    name = "id"
    type = "N"
  }

  attribute {
    name = "name"
    type = "S"
  }
}