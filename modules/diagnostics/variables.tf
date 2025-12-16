# =============================================================================
# Diagnostic Settings Module - Input Variables
# =============================================================================
# Defines configuration for Azure Monitor diagnostic settings.
# =============================================================================

variable "name" {
  type        = string
  description = "Name for the diagnostic setting resource"
}

variable "target_resource_id" {
  type        = string
  description = <<-EOT
    Azure resource ID to attach diagnostic settings to.
    This resource's logs and metrics will be sent to Log Analytics.
  EOT
}

variable "log_analytics_workspace_id" {
  type        = string
  description = <<-EOT
    Log Analytics workspace ID where logs and metrics are sent.
    Format: /subscriptions/{sub}/resourceGroups/{rg}/providers/.../workspaces/{name}
  EOT
}

variable "log_categories" {
  type        = list(string)
  description = <<-EOT
    List of log categories to enable.
    Categories vary by resource type (e.g., 'StorageRead' for storage, 'AuditEvent' for Key Vault).
    Use Azure Portal or CLI to discover available categories for each resource type.
  EOT
  default     = []
}

variable "metric_categories" {
  type        = list(string)
  description = <<-EOT
    List of metric categories to enable.
    'AllMetrics' is commonly used to capture all performance metrics.
  EOT
  default     = ["AllMetrics"]
}
