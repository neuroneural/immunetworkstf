variable "Lambda_path" {
  description = "Path to lambda_function.zip for cognito_lambda"
  type        = string
}

variable "Cognito_lambda_IAM_role_ARN" {
  description = "AWS ARN for Congit_lambda IAM role"
  type        = string
}

variable "cognito_user_pool_id" {
    description = "cognito user pool id"
    type = string
}

variable "cognito_user_pool_client_id" {
  description = "cognito user pool client id"
  type = string
}

variable "region" {
  description = "cognito user pool region to initialte boto3 calls"
  type = string
}
resource "aws_lambda_function" "Cognito_lambda_function" {
  function_name    = "Cognito_lambda"
  handler          = "handler.lambda_handler"
  runtime          = "python3.8"
  filename         = var.Lambda_path
  source_code_hash = filebase64(var.Lambda_path)

  role = var.Cognito_lambda_IAM_role_ARN

  environment {
    variables = {
      "cognito_user_pool_client_id" = var.cognito_user_pool_client_id
      "cognito_user_pool_id" = var.cognito_user_pool_id
      "region" = var.region
    }
  }
  timeout      = 300
  memory_size = 256
}

output "Cognito_Lambda_ARN" {
    value = aws_lambda_function.Cognito_lambda_function.arn
}

output "Cognito_Lambda_Invoke_ARN" {
  value = aws_lambda_function.Cognito_lambda_function.invoke_arn
}