variable "rest_api_id" {
  description = "API gateway app id"
  type = string
}

variable "parent_id" {
  description = "API gateway app root_resource_id"
  type = string
}

variable "user_list_Lambda_Invoke_ARN" {
  description = "Cognito Lambda Function ARN"
  type = string
}

variable "API_gateway_lamda_user_list_arn" {
  type = string
}
variable "authorization" {
  type = string
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}

resource "aws_api_gateway_resource" "user_runs" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "user_runs"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.user_runs.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = var.authorization
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.user_runs.id
  http_method = aws_api_gateway_method.get_method.http_method
  type                    = "AWS"
  integration_http_method = "POST"
  uri                     = var.user_list_Lambda_Invoke_ARN
  credentials = var.API_gateway_lamda_user_list_arn

  request_templates = {
    "application/json" = <<EOT
{
    "httpMethod": "$context.httpMethod"
}
EOT
  }
}

resource "aws_api_gateway_method_response" "runs_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.user_runs.id
  http_method = aws_api_gateway_method.get_method.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Content-Type" = "true",
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  response_models = {
    "application/json" = "Empty"  # Adjust this based on your response model
  }
}

resource "aws_api_gateway_integration_response" "runs_integration_response_1" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.user_runs.id
  http_method = aws_api_gateway_method.get_method.http_method
  status_code = aws_api_gateway_method_response.runs_response_1.status_code

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
  resource_id = aws_api_gateway_resource.user_runs.id
  amplify_url = var.amplify_url
}