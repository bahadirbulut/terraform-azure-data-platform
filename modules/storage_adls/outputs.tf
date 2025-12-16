# =============================================================================
# ADLS Gen2 Storage Module - Outputs
# =============================================================================
# Exposes storage account information for use by other resources.
# =============================================================================

output "account_name" {
  value       = azurerm_storage_account.this.name
  description = "Storage account name (used in notebooks and RBAC)"
}

output "dfs_endpoint" {
  value       = azurerm_storage_account.this.primary_dfs_endpoint
  description = "Data Lake Storage endpoint for hierarchical namespace access"
}

output "id" {
  value       = azurerm_storage_account.this.id
  description = "Storage account resource ID (used for RBAC assignments)"
}
