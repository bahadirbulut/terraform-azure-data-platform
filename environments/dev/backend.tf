# =============================================================================
# Remote State Backend Configuration - Development Environment
# =============================================================================
# Purpose: Store Terraform state in Azure Storage for team collaboration
#
# Benefits:
# - Shared state across team members
# - State locking to prevent concurrent modifications
# - State versioning and backup
# - Isolated state per environment (dev.tfstate, prod.tfstate, etc.)
#
# Prerequisites:
# - Storage account must already exist (create manually or via separate Terraform)
# - Ensure you have access to the storage account
#
# Initialize: terraform init
# =============================================================================

terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"               # RG containing state storage
    storage_account_name = "nexencetfstate123"        # State storage account
    container_name       = "tfstate"                  # Container for state files
    key                  = "terraform-azure-data-platform/dev.tfstate"  # State file path
  }
}
