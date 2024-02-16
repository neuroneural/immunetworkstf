variable "rest_api_id" {
  description = "API gateway app id"
  type = string
}

variable "parent_id" {
  description = "API gateway app root_resource_id"
  type = string
}

variable "lambda_invoke_arn" {
  type = string
}

variable "API_gateway_lamda_runs_arn" {
  type = string
}

variable "authorization" {
  type = string
}


variable "results_get_activity_Lambda_Invoke_ARN"{
  type =  string
}
variable "API_gateway_lamda_results_get_arn"{
  type =  string
}

resource "aws_api_gateway_resource" "results" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "results"
}

resource "aws_api_gateway_resource" "agggrad" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "agggrad"
}


module "POST_method" {
    source = "./POST"
    rest_api_id =var.rest_api_id
    authorization = var.authorization
    runs_id = aws_api_gateway_resource.results.id
    API_gateway_lamda_runs_arn = var.API_gateway_lamda_runs_arn
    lambda_invoke_arn = var.lambda_invoke_arn
}

module "GET_method" {
    source = "./GET"
    rest_api_id =var.rest_api_id
    authorization = var.authorization
    runs_id = aws_api_gateway_resource.agggrad.id
    API_gateway_lamda_runs_arn = var.API_gateway_lamda_results_get_arn
    lambda_invoke_arn = var.results_get_activity_Lambda_Invoke_ARN
}
