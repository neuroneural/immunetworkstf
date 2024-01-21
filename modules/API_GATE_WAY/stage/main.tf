variable "resource_id_list" {
  type    = list(string)
  description = "list of api sesource id's to deploy to stage"
}

variable "rest_api_id" {
  type    = string
  description = "API gateway ID to deploy stage"
}

variable "stage_name" {
  type = string
  description = "deployment stage name"
}


resource "aws_api_gateway_deployment" "stage" {
  rest_api_id = var.rest_api_id

  triggers = {
    redeployment = sha1(jsonencode(var.resource_id_list))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.stage.id
  rest_api_id   = var.rest_api_id
  stage_name    = var.stage_name
}


output "stage_url" {
  value = aws_api_gateway_stage.stage.invoke_url
}