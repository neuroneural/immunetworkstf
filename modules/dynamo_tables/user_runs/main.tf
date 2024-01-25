resource "aws_dynamodb_table" "user_runs" {
  name           = "user_runs"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "user_runs_table_name" {
  value = aws_dynamodb_table.user_runs.name
}

output "user_runs_table_arn" {
  value = aws_dynamodb_table.user_runs.arn
}