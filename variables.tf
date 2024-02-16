variable "aws_region" {
  description = "Enter AWS region for deployment"
  type        = string
}

variable "SNS_email" {
  description = "Enter Name of the security group"
  type        = string
}

variable "user_pool_name" {
  description = "Enter name for new cognito userpool"
  type        = string
}

variable "amplify_url" {
  description = "Enter name for new amplify url for enabling cors"
  type        = string
}