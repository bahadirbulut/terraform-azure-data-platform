# =============================================================================
# Databricks Secret Scope Module - Input Variables
# =============================================================================
# Defines configuration for linking Databricks to Azure Key Vault.
# =============================================================================

variable "scope_name" {
  type        = string
  description = <<-EOT
    Name of the Databricks secret scope.
    Used to access secrets: dbutils.secrets.get("keyvault", "secret-name")
  EOT
  default     = "keyvault"
}

variable "key_vault_id" {
  type        = string
  description = "Azure Resource ID of the Key Vault to link"
}

variable "key_vault_uri" {
  type        = string
  description = <<-EOT
    URI of the Key Vault (e.g., https://mykv.vault.azure.net/).
    Used by Databricks to retrieve secrets.
  EOT
}
