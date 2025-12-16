# =============================================================================
# Azure Monitor Diagnostic Settings Module
# =============================================================================
# Purpose: Configure log and metric collection for Azure resources
#
# Sends diagnostic data to Log Analytics workspace for:
# - Centralized monitoring and alerting
# - Security auditing and compliance
# - Performance troubleshooting
# =============================================================================

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.name
  target_resource_id         = var.target_resource_id          # Resource to monitor
  log_analytics_workspace_id = var.log_analytics_workspace_id  # Destination workspace

  # Enable specified log categories
  dynamic "enabled_log" {
    for_each = toset(var.log_categories)
    content {
      category = enabled_log.value
    }
  }

  # Enable specified metric categories
  dynamic "metric" {
    for_each = toset(var.metric_categories)
    content {
      category = metric.value
      enabled  = true
    }
  }
}
