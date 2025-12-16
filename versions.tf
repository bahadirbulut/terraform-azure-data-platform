# =============================================================================
# Terraform Version Requirements
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Define required Terraform and provider versions for compatibility
#
# This ensures consistent behavior across different environments and teams
# =============================================================================

terraform {
  # Minimum Terraform version required
  required_version = ">= 1.6.0"

  required_providers {
    # Azure Resource Manager provider for Azure infrastructure
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.110"  # Compatible with 3.110.x
    }
    
    # Databricks provider for workspace configuration
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.50"  # Compatible with 1.50.x
    }
  }
}
