variable "Cognito_lambda_function_Invoke_ARN" {
  description = "Cognito Lambda Function ARN to assign to login resource"
  type = string
}

variable "API_gateway_lamda_auth_arn" {
  type = string
}

module "login" {
  source = "./login"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
  API_gateway_lamda_auth_arn = var.API_gateway_lamda_auth_arn
}

module "identityadd" {
  source = "./identityadd"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
  API_gateway_lamda_auth_arn = var.API_gateway_lamda_auth_arn
}



resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "immunetworks"
  description = "REST API's for immunetworks"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
