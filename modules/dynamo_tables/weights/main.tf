resource "aws_dynamodb_table" "user_weights" {
  name           = "user_weights"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "user_weights_table_name" {
  value = aws_dynamodb_table.user_weights.name
}

output "user_weights_table_arn" {
  value = aws_dynamodb_table.user_weights.arn
}