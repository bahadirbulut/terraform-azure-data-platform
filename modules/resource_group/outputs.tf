# =============================================================================
# Resource Group Module - Outputs
# =============================================================================
# Exposes resource group information for use by other modules.
# =============================================================================

output "name" {
  value       = azurerm_resource_group.this.name
  description = "Name of the created resource group (used by other resources)"
}
