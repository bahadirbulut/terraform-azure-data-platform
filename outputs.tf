# =============================================================================
# Terraform Outputs - Resource Information
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Export important resource details for reference and integration
#
# Usage: Access via 'terraform output <output_name>'
# =============================================================================

# Resource Group
output "resource_group_name" {
  value = module.rg.name
  description = "Name of the resource group containing all platform resources"
}

# ADLS Gen2 Storage
output "adls_account_name" {
  value = module.adls.account_name
  description = "Storage account name for ADLS Gen2 (needed for notebook configuration)"
}

output "adls_dfs_endpoint" {
  value = module.adls.dfs_endpoint
  description = "DFS endpoint for ADLS Gen2 (hierarchical namespace)"
}

# Key Vault
output "key_vault_name" {
  value = module.kv.name
  description = "Key Vault name for secrets management"
}

# Log Analytics
output "log_analytics_workspace_id" {
  value = module.log.workspace_id
  description = "Log Analytics workspace ID for diagnostic settings"
}

# Databricks
output "databricks_workspace_url" {
  value = module.dbx.workspace_url
  description = "Databricks workspace URL for user access and API calls"
}
