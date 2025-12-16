output "workspace_url" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "id" {
  value = azurerm_databricks_workspace.this.id
}

output "managed_identity_principal_id" {
  value = azurerm_databricks_workspace.this.storage_account_identity[0].principal_id
  description = "Principal ID of the Databricks workspace managed identity"
}
