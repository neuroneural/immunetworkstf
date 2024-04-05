variable "rest_api_id" {
  description = "API gateway app id"
  type = string
}

variable "parent_id" {
  description = "API gateway app root_resource_id"
  type = string
}

variable "API_gateway_lamda_upload_weights_invoke_arn" {
  type = string
}

variable "API_gateway_lamda_upload_weights_arn" {
  type = string
}

variable "authorization" {
  type = string
}

variable "lambda_get_weights_invoke_arn" {
  type = string
}

variable "API_gateway_lamda_arn" {
  type = string
}

resource "aws_api_gateway_resource" "weights" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "weights"
}

resource "aws_api_gateway_resource" "weightsavg" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "weightsavg"
}


module "GET_method" {
    source = "./GET"
    rest_api_id =var.rest_api_id
    authorization = var.authorization
    runs_id = aws_api_gateway_resource.weightsavg.id
    API_gateway_lamda_arn = var.API_gateway_lamda_arn
    lambda_get_weights_invoke_arn = var.lambda_get_weights_invoke_arn
}

module "POST_method" {
    source = "./POST"
    rest_api_id =var.rest_api_id
    authorization = var.authorization
    runs_id = aws_api_gateway_resource.weights.id
    API_gateway_lamda_upload_weights_arn = var.API_gateway_lamda_upload_weights_arn
    lambda_invoke_arn = var.API_gateway_lamda_upload_weights_invoke_arn
}
