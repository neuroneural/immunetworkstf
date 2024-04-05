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

variable "API_gateway_lamda_runs_arn" {
  type = string
}

variable "authorization" {
  type = string
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}

resource "aws_api_gateway_resource" "runs" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "runs_update"
}


module "POST_method" {
    source = "./POST"
    rest_api_id =var.rest_api_id
    authorization = var.authorization
    runs_id = aws_api_gateway_resource.runs.id
    API_gateway_lamda_runs_arn = var.API_gateway_lamda_runs_arn
    lambda_invoke_arn = var.lambda_invoke_arn
    amplify_url = var.amplify_url
}

module "options" {
  source = "./options"
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.runs.id
  amplify_url = var.amplify_url
}