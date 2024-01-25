resource "aws_dynamodb_table" "results" {
  name           = "results"
  billing_mode   = "PROVISIONED"
  hash_key       = "runid"
  read_capacity  = 1
  write_capacity = 1
  

  attribute {
    name = "runid"
    type = "N"
  }
}

output "results_table_name" {
  value = aws_dynamodb_table.results.name
}

output "results_table_arn" {
  value = aws_dynamodb_table.results.arn
}