variable "scope_name" {
  type        = string
  description = "Name of the Databricks secret scope"
  default     = "keyvault"
}

variable "key_vault_id" {
  type        = string
  description = "Azure Resource ID of the Key Vault"
}

variable "key_vault_uri" {
  type        = string
  description = "URI of the Key Vault"
}
