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
}

module "Cognito_lambda_function" {
  source = "./modules/Cognito_lambda"
  Lambda_path = "./modules/Cognito_lambda/lambda/lambda_handler.zip"
  Cognito_lambda_IAM_role_ARN = module.Cognito_lambda_IAM_roles.Cognito_lambda_IAM_role_ARN
  cognito_user_pool_client_id = module.cognito_user_pool.cognito_user_pool_client_id
  cognito_user_pool_id =module.cognito_user_pool.cognito_user_pool_id
  region = var.aws_region

}

module "API_GATE_WAY" {
  source = "./modules/API_GATE_WAY"
  Cognito_lambda_function_Invoke_ARN = module.Cognito_lambda_function.Cognito_Lambda_Invoke_ARN
}
