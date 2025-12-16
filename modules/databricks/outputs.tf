# =============================================================================
# Databricks Workspace Module - Outputs
# =============================================================================
# Exposes workspace information for configuration and RBAC assignments.
# =============================================================================

output "workspace_url" {
  value       = azurerm_databricks_workspace.this.workspace_url
  description = "URL for accessing the Databricks workspace UI and APIs"
}

output "id" {
  value       = azurerm_databricks_workspace.this.id
  description = "Resource ID of the Databricks workspace"
}

output "managed_identity_principal_id" {
  value       = azurerm_databricks_workspace.this.storage_account_identity[0].principal_id
  description = <<-EOT
    Principal ID of the Databricks workspace managed identity.
    Used for granting RBAC permissions to Azure resources (e.g., ADLS).
  EOT
}
