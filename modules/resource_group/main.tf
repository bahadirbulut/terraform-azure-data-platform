# =============================================================================
# Azure Resource Group Module
# =============================================================================
# Purpose: Create a container for all platform resources
#
# Benefits:
# - Centralized lifecycle management
# - Grouped billing and cost tracking
# - Simplified RBAC and policy assignment
# - Easy cleanup (delete RG deletes all resources)
# =============================================================================

variable "name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

# Resource Group - Container for all Azure resources
resource "azurerm_resource_group" "this" {
  name     = var.name      # Resource group name
  location = var.location  # Azure region
  tags     = var.tags      # Common tags for governance
}
