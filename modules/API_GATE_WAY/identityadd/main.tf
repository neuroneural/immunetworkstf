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

variable "API_gateway_lamda_auth_arn" {
  type = string
}

resource "aws_api_gateway_resource" "identityadd" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "identityadd"
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.identityadd.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.identityadd.id
  http_method = aws_api_gateway_method.post_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
  credentials = var.API_gateway_lamda_auth_arn

  request_templates = {
    "application/json" = <<EOT
{
    "httpMethod": "$context.httpMethod",
    "resourceName": "$context.resourcePath",
    "USERNAME" : $input.json('$.username'),
    "PASSWORD" : $input.json('$.password'),
    "EMAIL": $input.json('$.email')
}
EOT
  }
}

resource "aws_api_gateway_method_response" "identityadd_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.identityadd.id
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

resource "aws_api_gateway_integration_response" "login_integration_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.identityadd.id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = aws_api_gateway_method_response.identityadd_response_1.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'${var.amplify_url}'"
  }
  response_templates = {
    "application/json" = ""  # Adjust this based on your response template
  }
}

module "options" {
  source = "./options"
  rest_api_id = var.rest_api_id
  amplify_url = var.amplify_url
  resource_id = aws_api_gateway_resource.identityadd.id
}