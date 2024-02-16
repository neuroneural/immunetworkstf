variable "Lambda_path" {
  description = "Path to lambda_function.zip for cognito_lambda"
  type        = string
}

variable "Runs_lambda_IAM_role_ARN" {
  description = "AWS ARN for Congit_lambda IAM role"
  type        = string
}

variable "Runs_table" {
    type = string
}

variable "Results_table" {
    type = string
}

variable "User_runs_table" {
    type = string
}

variable "Active_users_table" {
    type = string
}

variable "Last_active_table" {
  type = string
}

variable "region" {
  description = "cognito user pool region to initialte boto3 calls"
  type = string
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "get_results_lambda_function" {
  function_name    = "get_results_lambda"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
  filename         = var.Lambda_path
  source_code_hash = filebase64(var.Lambda_path)

  role = var.Runs_lambda_IAM_role_ARN

  layers = ["arn:aws:lambda:${data.aws_region.current.name}:336392948345:layer:AWSSDKPandas-Python38:13"]
  environment {
    variables = {
      "runs_table" = var.Runs_table
      "region" = var.region
      "active_users_table" =  var.Active_users_table
      "results_table" = var.Results_table
      "user_runs_table" = var.User_runs_table
      "last_active_table" = var.Last_active_table
    }
  }
  timeout      = 300
  memory_size = 256
}

output "get_results_Lambda_ARN" {
    value = aws_lambda_function.get_results_lambda_function.arn
}

output "get_results_Lambda_Invoke_ARN" {
  value = aws_lambda_function.get_results_lambda_function.invoke_arn
}