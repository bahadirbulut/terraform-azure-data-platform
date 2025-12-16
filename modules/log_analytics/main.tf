# =============================================================================
# Log Analytics Workspace Module
# =============================================================================
# Purpose: Centralized logging and monitoring for all platform resources
#
# Features:
# - Collects logs and metrics from all Azure resources
# - 30-day retention for cost efficiency
# - Pay-per-GB ingestion model
# - Enables queries, alerts, and dashboards
#
# Usage: Diagnostic settings send data to this workspace
# =============================================================================

variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

# Log Analytics Workspace - Centralized logging
resource "azurerm_log_analytics_workspace" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"      # Pay-per-GB pricing model
  retention_in_days   = 30               # Log retention period
  tags                = var.tags
}
