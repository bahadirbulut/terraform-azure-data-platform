# =============================================================================
# UAT Environment Configuration
# =============================================================================
# Purpose: Deploy the Azure data platform in UAT/staging environment
#
# This configuration demonstrates UAT-specific settings with higher capacity
# and additional features compared to dev, but more cost-effective than prod.
#
# Usage:
#   cd environments/uat
#   terraform init
#   terraform apply
# =============================================================================

# Reference the root module (main platform configuration)
module "platform" {
  source = "../../"  # Root module location

  # Core configuration
  project  = "nexence"
  env      = "uat"
  owner    = "bahadir"
  location = "westeurope"

  # Storage configuration
  adls_container_names = ["bronze", "silver", "gold"]
  
  # Databricks configuration - Premium for UAT testing
  databricks_sku = "premium"

  # Environment-specific tags
  extra_tags = {
    cost_center = "portfolio"
    environment = "uat"
    purpose     = "testing"
  }
}
