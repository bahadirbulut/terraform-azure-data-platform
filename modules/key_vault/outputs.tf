# =============================================================================
# Key Vault Module - Outputs
# =============================================================================
# Exposes Key Vault information for secret management and integration.
# =============================================================================

output "name" {
  value       = azurerm_key_vault.this.name
  description = "Name of the created Key Vault"
}

output "id" {
  value       = azurerm_key_vault.this.id
  description = "Resource ID of the Key Vault (used for secret scope configuration)"
}

output "vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "URI of the Key Vault (used for Databricks secret scope linking)"
}
