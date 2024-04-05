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
  user_list_lambda_ARN = module.cognito_list_users_lambda.Runs_Lambda_ARN
  user_activity_lambda_ARN = module.user_activiy_lambda.user_activity_lambda_ARN
  user_post_results_lambda_ARN = module.results_lambda.post_results_Lambda_ARN
  user_get_results_lambda_ARN = module.results_lambda.get_results_Lambda_ARN
  user_get_weights_Lambda_ARN = module.Weights_lambda.user_get_weights_Lambda_ARN
  user_weights_upload_Lambda_ARN = module.Weights_lambda.user_weights_upload_Lambda_ARN
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
  amplify_url = var.amplify_url
  cognito_user_pool_arn = module.cognito_user_pool.cognito_user_pool_arn
  
  Cognito_lambda_function_Invoke_ARN = module.Cognito_lambda_function.Cognito_Lambda_Invoke_ARN
  API_gateway_lamda_auth_arn = module.api_lambda_invocation_role.API_gateway_lamda_auth_arn
  
  Runs_Lambda_Invoke_ARN = module.runs_lambda.Runs_Lambda_Invoke_ARN
  API_gateway_lamda_runs_arn = module.api_lambda_invocation_role.API_gateway_lamda_runs_arn
  
  user_list_Lambda_Invoke_ARN = module.cognito_list_users_lambda.Runs_Lambda_Invoke_ARN
  API_gateway_lamda_user_list_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_lists_arn

  user_activity_Lambda_Invoke_ARN = module.user_activiy_lambda.user_activity_lambda_Invoke_ARN
  API_gateway_lamda_user_activity_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_activate_arn

  results_post_activity_Lambda_Invoke_ARN = module.results_lambda.post_results_Lambda_Invoke_ARN
  API_gateway_lamda_results_post_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_post_results_arn

  results_get_activity_Lambda_Invoke_ARN = module.results_lambda.get_results_Lambda_Invoke_ARN
  API_gateway_lamda_results_get_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_get_results_arn

  API_gateway_lamda_upload_weights_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_upload_weights_arn
  API_gateway_lamda_upload_weights_invoke_arn = module.Weights_lambda.user_weights_upload_Lambda_Invoke_ARN

  API_gateway_lamda_arn = module.api_lambda_invocation_role.API_gateway_lamda_user_get_weights_arn
  lambda_get_weights_invoke_arn = module.Weights_lambda.user_get_weights_Lambda_Invoke_ARN
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
  Dynamo_db_last_active_table_ARN = module.Dynamo_tables.last_Activity_table_arn
  Dynamo_db_weights_table_ARN = module.Dynamo_tables.weights_arn
}

module "runs_lambda" {
  source = "./modules/runs_lambda"
  region = var.aws_region
  Runs_lambda_IAM_role_ARN = module.runs_lambda_IAM_role.runs_lambda_IAM_role_ARN
  Runs_table = module.Dynamo_tables.Runs_table_name
  Active_users_table = module.Dynamo_tables.active_table_name
  Results_table = module.Dynamo_tables.results_table_name
  User_runs_table = module.Dynamo_tables.user_runs_table_name
  Last_active_table = module.Dynamo_tables.last_Activity_table_name
  weights_table = module.Dynamo_tables.weights_nane
  Lambda_path = "./modules/runs_lambda/lambda/lambda_runs_handler.zip"
}

module "user_activiy_lambda" {
  source = "./modules/user_activay_lambda"
  region = var.aws_region
  Runs_lambda_IAM_role_ARN = module.runs_lambda_IAM_role.runs_lambda_IAM_role_ARN
  Runs_table = module.Dynamo_tables.Runs_table_name
  Active_users_table = module.Dynamo_tables.active_table_name
  Results_table = module.Dynamo_tables.results_table_name
  User_runs_table = module.Dynamo_tables.user_runs_table_name
  Last_active_table = module.Dynamo_tables.last_Activity_table_name
  weights_table = module.Dynamo_tables.weights_nane
  Lambda_path = "./modules/user_activay_lambda/lambda/lambda_user_activiy_handler.zip"
}


module "Weights_lambda" {
  source = "./modules/Weights"
  region = var.aws_region
  Runs_lambda_IAM_role_ARN = module.runs_lambda_IAM_role.runs_lambda_IAM_role_ARN
  Runs_table = module.Dynamo_tables.Runs_table_name
  Active_users_table = module.Dynamo_tables.active_table_name
  Results_table = module.Dynamo_tables.results_table_name
  User_runs_table = module.Dynamo_tables.user_runs_table_name
  Last_active_table = module.Dynamo_tables.last_Activity_table_name
  weights_table = module.Dynamo_tables.weights_nane
  Upload_weightsLambda_path = "./modules/Weights/Upload/lambda/lambda_user_weights_upload_handler.zip"
  Get_weightsLambda_path = "./modules/Weights/GET/lambda/lambda_user_weights_get_handler.zip"
}

module "results_lambda" {
  source = "./modules/results_lambdas"
  region = var.aws_region
  Runs_lambda_IAM_role_ARN = module.runs_lambda_IAM_role.runs_lambda_IAM_role_ARN
  Runs_table = module.Dynamo_tables.Runs_table_name
  Active_users_table = module.Dynamo_tables.active_table_name
  Results_table = module.Dynamo_tables.results_table_name
  User_runs_table = module.Dynamo_tables.user_runs_table_name
  Last_active_table = module.Dynamo_tables.last_Activity_table_name
  Lambda_path = "./modules/results_lambdas/post_results/lambda/lambda_post_results_activiy_handler.zip"
  GET_Lambda_path = "./modules/results_lambdas/get_results/lambda/lambda_get_results_activiy_handler.zip"
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

