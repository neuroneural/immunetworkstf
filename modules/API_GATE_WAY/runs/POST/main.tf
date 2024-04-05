variable "rest_api_id" {
  description = "API gateway app id"
  type = string
}

variable "lambda_invoke_arn" {
  description = "Cognito Lambda Function ARN"
  type = string
}

variable "API_gateway_lamda_runs_arn" {
  type = string
}

variable "authorization" {
  type = string
}

variable "runs_id" {
    type = string
  
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.runs_id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorization
}

resource "aws_api_gateway_integration" "lambda_integration_1" {
  rest_api_id = var.rest_api_id
  resource_id = var.runs_id
  http_method = aws_api_gateway_method.post_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
  credentials = var.API_gateway_lamda_runs_arn

  request_templates = {
    "application/json" = <<EOT
{
    "httpMethod": "$context.httpMethod",
    "userEmail": "$context.authorizer.claims.email",
    "resourceName": "$context.resourcePath"
}
EOT
  }
}

resource "aws_api_gateway_method_response" "runs_response_2" {
  rest_api_id = var.rest_api_id
  resource_id = var.runs_id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Content-Type" = "true",
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  response_models = {
    "application/json" = "Empty"  # Adjust this based on your response model
  }
}

resource "aws_api_gateway_integration_response" "runs_integration_response_2" {
  rest_api_id = var.rest_api_id
  resource_id = var.runs_id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = aws_api_gateway_method_response.runs_response_2.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'${var.amplify_url}'"
  }

  response_templates = {
    "application/json" = ""  # Adjust this based on your response template
  }
}