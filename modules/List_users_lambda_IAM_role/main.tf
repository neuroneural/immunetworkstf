variable "user_pool_table_ARN" {
    type = string
}

# iam_roles/main.tf
resource "aws_iam_role" "lambda_execution_role" {
  name = "cognito_list_users_lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}


# IAM Role for Cognito User Pool Client
resource "aws_iam_policy" "inline_policy" {
  name        = "cognito_list_users_inline_policy"
  description = "Inline policy for Lambda function"
  
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "cognito-idp:ListUsers",
			"Resource":"${var.user_pool_table_ARN}"
		}
	]
}
EOF
}

# Attach the default Lambda basic execution policy to the Lambda Execution Role
resource "aws_iam_role_policy_attachment" "lambda_execution_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_execution_role.name
}

resource "aws_iam_role_policy_attachment" "attach_inline_policy" {
  policy_arn = aws_iam_policy.inline_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}

output "cognito_list_users_lambda_IAM_role_ARN" {
  value = aws_iam_role.lambda_execution_role.arn
}