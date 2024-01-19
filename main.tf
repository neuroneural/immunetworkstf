provider "aws" {
  region = var.aws_region
}

module "cognito_user_pool" {
  source = "./modules/cognito_user_pool"

  cognito_user_pool_name           = var.user_pool_name
  SNS_email_id = var.SNS_email
  # cognito_client_name      = var.user_pool_name
}

module "Cognito_lambda_IAM_roles" {
  source = "./modules/Cognito_lambda_IAM_roles"

  cognito_user_pool_id         = module.cognito_user_pool.cognito_user_pool_id
}