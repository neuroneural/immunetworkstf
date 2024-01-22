variable "Cognito_lambda_function_Invoke_ARN" {
  description = "Cognito Lambda Function ARN to assign to login resource"
  type = string
}

module "login" {
  source = "./login"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
}

module "signup" {
  source = "./signup"
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  lambda_invoke_arn = var.Cognito_lambda_function_Invoke_ARN
}

resource "aws_api_gateway_deployment" "dev" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  triggers = {
    redeployment = sha1(jsonencode([
      module.signup.signup_resource,
      module.signup.signup_method_1,
      module.signup.signup_integration_1,
      module.signup.signup_integration_response_1,
      module.signup.aws_api_gateway_method_response_1,
      module.login.login_resource,
      module.login.login_method_1,
      module.login.login_integration_1
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "dev" {
  deployment_id = aws_api_gateway_deployment.dev.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = "dev"
}



resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "immunetworks"
  description = "REST API's for immunetworks"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


output "stage_url" {
  value = aws_api_gateway_stage.dev.invoke_url
}