# =============================================================================
# Azure Key Vault Module
# =============================================================================
# Purpose: Centralized secrets management for platform
#
# Features:
# - Soft delete with 7-day retention
# - Public access enabled (portfolio/dev mode)
# - Standard SKU for cost efficiency
# =============================================================================

variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

# Get current Azure tenant ID
data "azurerm_client_config" "current" {}

# Key Vault for secrets management
resource "azurerm_key_vault" "this" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"  # Standard tier (sufficient for most workloads)

  soft_delete_retention_days  = 7      # Recover deleted secrets within 7 days
  purge_protection_enabled    = false  # Dev-friendly; enable in production

  # Portfolio defaults: public network allowed for simplicity
  # For production: enable private endpoints + network_acls
  public_network_access_enabled = true

  tags = var.tags
}
