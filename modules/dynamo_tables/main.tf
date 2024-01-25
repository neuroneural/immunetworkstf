module "runs" {
    source = "./runs"
}

module "active" {
  source = "./active"
}

module "user_runs" {
  source = "./user_runs"
}

module "results" {
  source = "./results"
}

output "Runs_table_arn" {
  value = module.runs.runs_table_arn
}

output "Runs_table_name" {
  value = module.runs.runs_table_name
}

output "active_table_arn" {
  value = module.active.active_users_table_arn
}

output "active_table_name" {
  value = module.active.active_users_table_name
}

output "user_runs_table_arn" {
  value = module.user_runs.user_runs_table_arn
}

output "user_runs_table_name" {
  value = module.user_runs.user_runs_table_name
}

output "results_table_arn" {
  value = module.results.results_table_arn
}

output "results_table_name" {
  value = module.results.results_table_name
}