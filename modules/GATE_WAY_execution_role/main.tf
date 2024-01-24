variable "Cognito_Lambda_ARN" {
  description = "ARN of the Lambda function"
  type = string
}

variable "runs_lambda_ARN" {
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

output "API_gateway_lamda_runs_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role_1.arn
}

output "API_gateway_lamda_auth_arn" {
  value = aws_iam_role.api_gateway_invoke_lambda_execution_role.arn
}