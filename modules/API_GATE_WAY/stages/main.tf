resource "aws_api_gateway_deployment" "stage" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
  ]
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_stage" "stage" {
  rest_api_id = var.rest_api_id
  stage_name  = var.stage_name
  deployment_id = aws_api_gateway_deployment.stage.id
}