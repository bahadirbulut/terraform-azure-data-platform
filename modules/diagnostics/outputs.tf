# =============================================================================
# Diagnostic Settings Module - Outputs
# =============================================================================
# Exposes diagnostic setting information for reference.
# =============================================================================

output "id" {
  value       = azurerm_monitor_diagnostic_setting.this.id
  description = "Resource ID of the created diagnostic setting"
}
