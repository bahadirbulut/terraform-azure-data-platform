output "resource_group_name" {
  value = module.rg.name
}

output "adls_account_name" {
  value = module.adls.account_name
}

output "adls_dfs_endpoint" {
  value = module.adls.dfs_endpoint
}

output "key_vault_name" {
  value = module.kv.name
}

output "log_analytics_workspace_id" {
  value = module.log.workspace_id
}

output "databricks_workspace_url" {
  value = module.dbx.workspace_url
}
