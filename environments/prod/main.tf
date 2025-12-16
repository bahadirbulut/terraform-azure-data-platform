# =============================================================================
# Production Environment Configuration
# =============================================================================
# Purpose: Deploy the Azure data platform in production environment
#
# This configuration uses production-grade settings with enhanced features,
# higher availability, and appropriate safeguards for production workloads.
#
# IMPORTANT: Review all settings carefully before deploying to production!
#
# Usage:
#   cd environments/prod
#   terraform init
#   terraform apply
# =============================================================================

# Reference the root module (main platform configuration)
module "platform" {
  source = "../../"  # Root module location

  # Core configuration
  project  = "nexence"
  env      = "prod"
  owner    = "bahadir"
  location = "westeurope"

  # Storage configuration
  adls_container_names = ["bronze", "silver", "gold"]
  
  # Databricks configuration - Premium required for production
  databricks_sku = "premium"

  # Environment-specific tags
  extra_tags = {
    cost_center   = "portfolio"
    environment   = "production"
    criticality   = "high"
    backup        = "required"
  }
}

# =============================================================================
# Production Considerations (Not Yet Implemented)
# =============================================================================
# For true production deployment, consider adding:
#
# 1. Enhanced Security:
#    - Enable private endpoints for Storage and Key Vault
#    - Configure VNet injection for Databricks
#    - Implement network ACLs and firewall rules
#
# 2. High Availability:
#    - Use Zone-Redundant Storage (ZRS) instead of LRS
#    - Configure geo-redundancy for critical data
#
# 3. Compliance & Governance:
#    - Enable Key Vault purge protection
#    - Configure longer log retention (90+ days)
#    - Implement Azure Policy for compliance
#
# 4. Disaster Recovery:
#    - Set up backup policies for storage accounts
#    - Configure disaster recovery procedures
#    - Document incident response plans
#
# 5. Cost Management:
#    - Set up budget alerts
#    - Configure Azure Cost Management
#    - Implement resource tagging strategy
# =============================================================================
