module "runs" {
    source = "./runs"
}

output "Runs_table_arn" {
  value = module.runs.runs_table_arn
}

output "Runs_table_name" {
  value = module.runs.runs_table_name
}