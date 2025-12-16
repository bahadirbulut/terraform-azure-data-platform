# =====================================================================
# Local Values
# =====================================================================
# This file defines reusable local values that are computed from 
# input variables and used throughout the Terraform configuration.
# Locals promote DRY principles and ensure consistency across resources.
# =====================================================================

locals {
  # Standardized naming prefix for all resources
  # Combines project name and environment to ensure unique resource names
  # Example: "myproject-dev" → "myproject-dev-storage", "myproject-dev-kv"
  name_prefix = "${var.project}-${var.env}"

  # Common tags applied to all Azure resources
  # Provides consistent metadata for resource management, cost tracking, 
  # and governance across the entire platform
  common_tags = merge(
    {
      project    = var.project      # Project identifier
      env        = var.env          # Environment (dev/staging/prod)
      owner      = var.owner        # Team or individual responsible
      managed_by = "terraform"      # Indicates IaC management
    },
    var.extra_tags                  # Additional custom tags from variables
  )
}
