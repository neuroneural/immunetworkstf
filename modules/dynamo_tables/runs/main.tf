resource "aws_dynamodb_table" "runs" {
  name           = "runs"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "runs_table_name" {
  value = aws_dynamodb_table.runs.name
}

output "runs_table_arn" {
  value = aws_dynamodb_table.runs.arn
}