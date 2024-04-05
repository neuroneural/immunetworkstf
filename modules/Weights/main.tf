variable "Upload_weightsLambda_path" {
  type        = string
}


variable "Get_weightsLambda_path" {
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

variable "weights_table" {
  type = string
}


module "Upload_weights" {
  source = "./Upload"
  region = var.region
  Runs_lambda_IAM_role_ARN = var.Runs_lambda_IAM_role_ARN
  Runs_table = var.Runs_table
  Active_users_table = var.Active_users_table
  Results_table = var.Results_table
  User_runs_table = var.User_runs_table
  Last_active_table = var.Last_active_table
  weights_table = var.weights_table
  Lambda_path = var.Upload_weightsLambda_path
}

module "Get_weights" {
  source = "./GET"
  region = var.region
  Runs_lambda_IAM_role_ARN = var.Runs_lambda_IAM_role_ARN
  Runs_table = var.Runs_table
  Active_users_table = var.Active_users_table
  Results_table = var.Results_table
  User_runs_table = var.User_runs_table
  Last_active_table = var.Last_active_table
  weights_table = var.weights_table
  Lambda_path = var.Get_weightsLambda_path
}

output "user_weights_upload_Lambda_ARN" {
    value = module.Upload_weights.user_weights_upload_lambda_ARN
}

output "user_weights_upload_Lambda_Invoke_ARN" {
  value = module.Upload_weights.user_weights_upload_Invoke_ARN
}

output "user_get_weights_Lambda_ARN" {
    value = module.Get_weights.user_weights_get_lambda_ARN
}

output "user_get_weights_Lambda_Invoke_ARN" {
  value = module.Get_weights.user_weights_get_lambda_Invoke_ARN
}