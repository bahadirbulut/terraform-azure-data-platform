# =============================================================================
# Log Analytics Workspace Module - Outputs
# =============================================================================
# Exposes workspace information for diagnostic settings configuration.
# =============================================================================

output "workspace_id" {
  value       = azurerm_log_analytics_workspace.this.workspace_id
  description = "Workspace ID (used by diagnostic settings to send logs)"
}

output "name" {
  value       = azurerm_log_analytics_workspace.this.name
  description = "Name of the Log Analytics workspace"
}
