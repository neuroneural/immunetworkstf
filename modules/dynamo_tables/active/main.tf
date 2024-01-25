resource "aws_dynamodb_table" "active_users" {
  name           = "active_users"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "active_users_table_name" {
  value = aws_dynamodb_table.active_users.name
}

output "active_users_table_arn" {
  value = aws_dynamodb_table.active_users.arn
}