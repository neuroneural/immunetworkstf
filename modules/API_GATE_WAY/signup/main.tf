variable "rest_api_id" {
  description = "API gateway app id"
  type = string
}

variable "parent_id" {
  description = "API gateway app root_resource_id"
  type = string
}

variable "lambda_invoke_arn" {
  description = "Cognito Lambda Function ARN"
  type = string
}

resource "aws_api_gateway_resource" "signup" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "signup"
}

resource "aws_api_gateway_method" "put_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.signup.id
  http_method   = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.put_method.http_method
  type                    = "AWS"
  integration_http_method = "PUT"
  uri                     = var.lambda_invoke_arn
}

resource "aws_api_gateway_method_response" "signup_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.put_method.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Content-Type" = "true"
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  response_models = {
    "application/json" = "Empty"  # Adjust this based on your response model
  }
}

resource "aws_api_gateway_integration_response" "signup_integration_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.signup.id
  http_method = aws_api_gateway_method.put_method.http_method
  status_code = aws_api_gateway_method_response.signup_response_1.status_code

  response_parameters = {
    "method.response.header.Content-Type" = "'application/json'"
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = ""  # Adjust this based on your response template
  }
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration # Add this line
  ]

  rest_api_id = var.rest_api_id
  stage_name = "dev"
}

output "signup_resource" {
  value = aws_api_gateway_resource.signup.id
}

output "signup_method_1" {
  value =   aws_api_gateway_method.put_method.id
}

output "signup_integration_1" {
  value = aws_api_gateway_integration.lambda_integration.id
}

output "signup_integration_response_1" {
  value = aws_api_gateway_integration_response.signup_integration_response_1.id
}

output "aws_api_gateway_method_response_1" {
  value = aws_api_gateway_method_response.signup_response_1.id
}
