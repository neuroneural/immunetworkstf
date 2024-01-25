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

module "api_lambda_invocation_role" {
  source = "./modules/GATE_WAY_execution_role"
  Cognito_Lambda_ARN = module.Cognito_lambda_function.Cognito_Lambda_ARN
  runs_lambda_ARN = module.runs_lambda.Runs_Lambda_ARN
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
  API_gateway_lamda_auth_arn = module.api_lambda_invocation_role.API_gateway_lamda_auth_arn
  cognito_user_pool_arn = module.cognito_user_pool.cognito_user_pool_arn
  Runs_Lambda_Invoke_ARN = module.runs_lambda.Runs_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = module.api_lambda_invocation_role.API_gateway_lamda_runs_arn
}

module "Dynamo_tables" {
  source = "./modules/dynamo_tables"
}

module "runs_lambda_IAM_role" {
  source = "./modules/runs_lambda_IAM_role"
  Dynamo_db_runs_table_ARN = module.Dynamo_tables.Runs_table_arn
  Dynamo_db_active_users_table_ARN = module.Dynamo_tables.active_table_arn
  Dynamo_db_user_runs_table_ARN = module.Dynamo_tables.user_runs_table_arn
  Dynamo_db_results_table_ARN = module.Dynamo_tables.results_table_arn
}

module "runs_lambda" {
  source = "./modules/runs_lambda"
  region = var.aws_region
  Runs_lambda_IAM_role_ARN = module.runs_lambda_IAM_role.runs_lambda_IAM_role_ARN
  Runs_table = module.Dynamo_tables.Runs_table_name
  Lambda_path = "./modules/runs_lambda/lambda/lambda_runs_handler.zip"
}

module "cognito_list_users_lambda_IAM_role" {
  source = "./modules/List_users_lambda_IAM_role"
  user_pool_table_ARN = module.cognito_user_pool.cognito_user_pool_arn
}

module "cognito_list_users_lambda" {
  source = "./modules/List_users_lambda"
  region = var.aws_region
  cognito_list_users_lambda_IAM_role_ARN = module.cognito_list_users_lambda_IAM_role.cognito_list_users_lambda_IAM_role_ARN
  Runs_table = module.cognito_user_pool.cognito_user_pool_id
  Lambda_path = "./modules/List_users_lambda/lambda/lambda_get_users_handler.zip"
}

