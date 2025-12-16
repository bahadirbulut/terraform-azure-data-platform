# =============================================================================
# Key Vault Module - Input Variables
# =============================================================================
# Defines configuration parameters for Azure Key Vault.
# =============================================================================

variable "name" {
  type        = string
  description = <<-EOT
    Name of the Key Vault.
    Must be globally unique, 3-24 characters, alphanumeric and hyphens only.
    Example: myproject-dev-kv (hyphens will be removed in processing)
  EOT
}

variable "location" {
  type        = string
  description = "Azure region for the Key Vault"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the Key Vault will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault"
}
