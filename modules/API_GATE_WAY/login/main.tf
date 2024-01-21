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

resource "aws_api_gateway_resource" "login" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "login"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.post_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = var.lambda_invoke_arn
}

output "login_resource" {
  value = aws_api_gateway_resource.login
}

output "login_method_1" {
  value =   aws_api_gateway_method.post_method.id
}

output "login_integration_1" {
  value = aws_api_gateway_integration.lambda_integration.id
}