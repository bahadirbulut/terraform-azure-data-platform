# =============================================================================
# Azure Databricks Workspace Module
# =============================================================================
# Purpose: Create Azure Databricks workspace for unified analytics
#
# Features:
# - Premium SKU (recommended for RBAC and compliance)
# - Managed identity enabled automatically by Azure
# - Workspace only - no compute costs until clusters created
# =============================================================================

variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "sku" { type = string }  # "standard" or "premium"
variable "tags" { type = map(string) }

# Databricks Workspace - Control plane resource
resource "azurerm_databricks_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku  # Premium recommended for production

  tags = var.tags
  
  # Managed identity automatically created by Azure for workspace
  # Used for authentication to Azure resources (ADLS, Key Vault, etc.)
}
