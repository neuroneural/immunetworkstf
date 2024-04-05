variable "Cognito_Lambda_ARN" {
  description = "ARN of the Lambda function"
  type = string
}

variable "runs_lambda_ARN" {
  type = string
}

variable "user_list_lambda_ARN" {
  type = string
}

variable "user_activity_lambda_ARN" {
  type = string
}

variable "user_post_results_lambda_ARN"{
  type = string
}

variable "user_get_results_lambda_ARN"{
  type = string
}


variable "user_get_weights_Lambda_ARN"{
  type = string
}

variable "user_weights_upload_Lambda_ARN"{
  type = string
}


# iam_roles/main.tf - authentication
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role" {
  name = "api_gateway_invoke_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Cognito User Pool Client
resource "aws_iam_policy" "inline_policy" {
  name        = "api_gatway_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.Cognito_Lambda_ARN}"
		}
	]
}
EOF
}
# Attach the default Lambda basic execution policy to the Lambda Execution Role
resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy" {
  policy_arn = aws_iam_policy.inline_policy.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role.name
}


# iam roles - runs
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_1" {
  name = "api_gateway_invoke_runs_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Cognito User Pool Client
resource "aws_iam_policy" "inline_policy_1" {
  name        = "api_gatway_runs_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.runs_lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_1" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_1.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_1" {
  policy_arn = aws_iam_policy.inline_policy_1.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_1.name
}




# iam roles - user_lists
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_2" {
  name = "api_gateway_invoke_user_lists_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Cognito User Pool Client
resource "aws_iam_policy" "inline_policy_2" {
  name        = "api_gatway_user_lists_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_list_lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_2" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_2.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_2" {
  policy_arn = aws_iam_policy.inline_policy_2.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_2.name
}


# iam roles - user_activity
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_3" {
  name = "api_gateway_invoke_user_activity_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Cognito User Pool Client
resource "aws_iam_policy" "inline_policy_3" {
  name        = "api_gatway_user_activity_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_activity_lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_3" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_3.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_3" {
  policy_arn = aws_iam_policy.inline_policy_3.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_3.name
}


# iam roles - Post Results
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_4" {
  name = "api_gateway_invoke_user_post_results_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Post results
resource "aws_iam_policy" "inline_policy_4" {
  name        = "api_gatway_user_post_results_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_post_results_lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_4" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_4.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_4" {
  policy_arn = aws_iam_policy.inline_policy_4.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_4.name
}


# iam roles - GET Results
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_5" {
  name = "api_gateway_invoke_user_get_results_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM Role for GET results
resource "aws_iam_policy" "inline_policy_5" {
  name        = "api_gatway_user_get_results_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_get_results_lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_5" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_5.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_5" {
  policy_arn = aws_iam_policy.inline_policy_5.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_5.name
}



# iam roles - GET Weights
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_6" {
  name = "api_gateway_invoke_user_get_weights_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM inline for GET weights
resource "aws_iam_policy" "inline_policy_6" {
  name        = "api_gatway_user_get_weights_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_get_weights_Lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_6" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_6.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_6" {
  policy_arn = aws_iam_policy.inline_policy_6.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_6.name
}


# iam roles - Upload Weights
resource "aws_iam_role" "api_gateway_invoke_lambda_execution_role_7" {
  name = "api_gateway_invoke_user_upload_weights_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "apigateway.amazonaws.com"
      }
    }]
  })
}


# IAM inline for Upload weights
resource "aws_iam_policy" "inline_policy_7" {
  name        = "api_gatway_user_upload_weights_lambda_invocation_inline_policy"
  description = "Inline policy for API gateway function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "lambda:InvokeFunction",
			"Resource": "${var.user_weights_upload_Lambda_ARN}"
		}
	]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonAPIGatewayPushToCloudWatchLogs_policy_attachment_7" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_7.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy_7" {
  policy_arn = aws_iam_policy.inline_policy_7.arn
  role       = aws_iam_role.api_gateway_invoke_lambda_execution_role_7.name
}

output "API_gateway_lamda_user_upload_weights_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_7.arn
}

output "API_gateway_lamda_user_get_weights_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_6.arn
}

output "API_gateway_lamda_user_get_results_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_5.arn
}

output "API_gateway_lamda_user_post_results_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_4.arn
}

output "API_gateway_lamda_user_activate_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_3.arn
}

output "API_gateway_lamda_user_lists_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_2.arn
}

output "API_gateway_lamda_runs_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_1.arn
}

output "API_gateway_lamda_auth_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role.arn
}