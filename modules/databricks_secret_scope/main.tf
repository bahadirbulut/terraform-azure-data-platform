# =============================================================================
# Databricks Secret Scope Module (Key Vault-backed)
# =============================================================================
# Purpose: Link Databricks workspace to Azure Key Vault for secrets management
#
# Benefits:
# - Centralized secret storage in Key Vault
# - No secrets stored in Databricks workspace
# - Access via dbutils.secrets.get("keyvault", "secret-name")
# - Automatic sync when secrets updated in Key Vault
# =============================================================================

resource "databricks_secret_scope" "kv" {
  name = var.scope_name  # Default: "keyvault"

  # Link to Azure Key Vault
  keyvault_metadata {
    resource_id = var.key_vault_id   # Azure Resource ID
    dns_name    = var.key_vault_uri  # Vault URI for access
  }
  
  # Note: Secrets are managed in Key Vault, not in Databricks
}
