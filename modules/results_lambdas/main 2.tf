variable "Lambda_path" {
  description = "Path to lambda_function.zip for cognito_lambda"
  type        = string
}

variable "GET_Lambda_path" {
  description = "Path to lambda_function.zip for cognito_lambda"
  type        = string
}


variable "Runs_lambda_IAM_role_ARN" {
  description = "AWS ARN for Congit_lambda IAM role"
  type        = string
}

variable "Runs_table" {
    type = string
}

variable "Results_table" {
    type = string
}

variable "User_runs_table" {
    type = string
}

variable "Active_users_table" {
    type = string
}

variable "Last_active_table" {
  type = string
}

variable "region" {
  description = "cognito user pool region to initialte boto3 calls"
  type = string
}

module "POST_RESULTS" {
  source = "./post_results"
  region = var.region
  Runs_lambda_IAM_role_ARN = var.Runs_lambda_IAM_role_ARN
  Runs_table = var.Runs_table
  Active_users_table = var.Active_users_table
  Results_table = var.Results_table
  User_runs_table = var.User_runs_table
  Last_active_table = var.Last_active_table
  Lambda_path = var.Lambda_path

}

module "GET_RESULTS" {
  source = "./get_results"
  region = var.region
  Runs_lambda_IAM_role_ARN = var.Runs_lambda_IAM_role_ARN
  Runs_table = var.Runs_table
  Active_users_table = var.Active_users_table
  Results_table = var.Results_table
  User_runs_table = var.User_runs_table
  Last_active_table = var.Last_active_table
  Lambda_path = var.GET_Lambda_path

}

output "post_results_Lambda_ARN" {
    value = module.POST_RESULTS.post_results_Lambda_ARN
}

output "post_results_Lambda_Invoke_ARN" {
  value = module.POST_RESULTS.post_results_Lambda_Invoke_ARN
}

output "get_results_Lambda_ARN" {
    value = module.GET_RESULTS.get_results_Lambda_ARN
}

output "get_results_Lambda_Invoke_ARN" {
  value = module.GET_RESULTS.get_results_Lambda_Invoke_ARN
}