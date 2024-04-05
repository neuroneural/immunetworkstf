resource "aws_dynamodb_table" "last_active" {
  name           = "last_active"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "last_active_table_name" {
  value = aws_dynamodb_table.last_active.name
}

output "last_active_table_arn" {
  value = aws_dynamodb_table.last_active.arn
}