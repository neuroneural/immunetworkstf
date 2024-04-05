variable "Cognito_lambda_function_Invoke_ARN" {
  description = "Cognito Lambda Function ARN to assign to login resource"
  type = string
}
variable "Runs_Lambda_Invoke_ARN" {
  type = string
}

variable "user_list_Lambda_Invoke_ARN" {
  type = string
}

variable "user_activity_Lambda_Invoke_ARN"{
  type = string
}
variable "API_gateway_lamda_user_activity_arn" {
  type = string
}

variable "results_post_activity_Lambda_Invoke_ARN"{
  type =  string
}
variable "API_gateway_lamda_results_post_arn"{
  type =  string
}


variable "results_get_activity_Lambda_Invoke_ARN"{
  type =  string
}
variable "API_gateway_lamda_results_get_arn"{
  type =  string
}

variable "API_gateway_lamda_runs_arn" {
  type = string
}
variable "API_gateway_lamda_auth_arn" {
  type = string
}
variable "API_gateway_lamda_user_list_arn" {
  type = string
}

variable "cognito_user_pool_arn" {
  type = string
  
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}
variable "API_gateway_lamda_upload_weights_invoke_arn" {
  type = string
}

variable "API_gateway_lamda_upload_weights_arn" {
  type = string
}

variable "API_gateway_lamda_arn" {
  type = string
}

variable "lambda_get_weights_invoke_arn" {
  type = string
}

module "weights" {
  source = "./weights"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  authorization = aws_api_gateway_authorizer.cognito.id
  API_gateway_lamda_upload_weights_arn = var.API_gateway_lamda_upload_weights_arn
  API_gateway_lamda_upload_weights_invoke_arn = var.API_gateway_lamda_upload_weights_invoke_arn
  API_gateway_lamda_arn = var.API_gateway_lamda_arn
  lambda_get_weights_invoke_arn = var.lambda_get_weights_invoke_arn
}


module "login" {
  source = "./login"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
  API_gateway_lamda_auth_arn = var.API_gateway_lamda_auth_arn
  amplify_url = var.amplify_url
}

module "identityadd" {
  source = "./identityadd"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
  API_gateway_lamda_auth_arn = var.API_gateway_lamda_auth_arn
  amplify_url = var.amplify_url
}



resource "aws_api_gateway_authorizer" "cognito" {
  name          = "cognito-authorizer"
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [var.cognito_user_pool_arn]
}

module "runs" {
  source = "./runs"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Runs_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = var.API_gateway_lamda_runs_arn
  authorization = aws_api_gateway_authorizer.cognito.id
  amplify_url = var.amplify_url
  }

module "runs_update" {
  source = "./runs_update"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Runs_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = var.API_gateway_lamda_runs_arn
  authorization = aws_api_gateway_authorizer.cognito.id
  amplify_url = var.amplify_url
  }

module "user_runs" {
  source = "./user_runs"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  user_list_Lambda_Invoke_ARN = var.user_list_Lambda_Invoke_ARN
  API_gateway_lamda_user_list_arn = var.API_gateway_lamda_user_list_arn
  authorization = aws_api_gateway_authorizer.cognito.id
  amplify_url = var.amplify_url
}

module "user_activation" {
  source = "./user_activation"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.user_activity_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = var.API_gateway_lamda_user_activity_arn
  authorization = aws_api_gateway_authorizer.cognito.id
}

module "results" {
  source = "./results"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.results_post_activity_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = var.API_gateway_lamda_results_post_arn
  authorization = aws_api_gateway_authorizer.cognito.id
  API_gateway_lamda_results_get_arn = var.API_gateway_lamda_results_get_arn
  results_get_activity_Lambda_Invoke_ARN = var.results_get_activity_Lambda_Invoke_ARN
}


resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "immunetworks"
  description = "REST API's for immunetworks"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
