# =============================================================================
# Provider Configurations
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Configure cloud provider authentication and settings
#
# Note: Provider version requirements are defined in versions.tf
# Authentication: Uses Azure CLI (az login) by default
# =============================================================================

# -----------------------------------------------------------------------------
# Azure Resource Manager Provider
# -----------------------------------------------------------------------------
# Manages Azure infrastructure resources
provider "azurerm" {
  features {
    key_vault {
      # Permanently delete Key Vault on destroy (dev-friendly)
      # For production, set to false to enable recovery
      purge_soft_delete_on_destroy = true
    }
  }
}

# -----------------------------------------------------------------------------
# Databricks Provider
# -----------------------------------------------------------------------------
# Manages Databricks workspace resources (clusters, jobs, repos)
# Authenticated via Azure CLI (az login) by default
provider "databricks" {
  host = var.databricks_host  # Set after workspace creation
}
