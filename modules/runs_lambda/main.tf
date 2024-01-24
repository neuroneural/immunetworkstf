variable "Lambda_path" {
  description = "Path to lambda_function.zip for cognito_lambda"
  type        = string
}

variable "Runs_lambda_IAM_role_ARN" {
  description = "AWS ARN for Congit_lambda IAM role"
  type        = string
}

variable "Runs_table" {
    description = "cognito user pool id"
    type = string
}

variable "region" {
  description = "cognito user pool region to initialte boto3 calls"
  type = string
}

resource "aws_lambda_function" "Runs_lambda_function" {
  function_name    = "runs_lambda"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
  filename         = var.Lambda_path
  source_code_hash = filebase64(var.Lambda_path)

  role = var.Runs_lambda_IAM_role_ARN

  environment {
    variables = {
      "runs_table" = var.Runs_table
      "region" = var.region
    }
  }
}

output "Runs_Lambda_ARN" {
    value = aws_lambda_function.Runs_lambda_function.arn
}

output "Runs_Lambda_Invoke_ARN" {
  value = aws_lambda_function.Runs_lambda_function.invoke_arn
}