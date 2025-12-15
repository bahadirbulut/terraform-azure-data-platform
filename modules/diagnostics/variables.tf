variable "name" {
  type        = string
  description = "Diagnostic setting name"
}

variable "target_resource_id" {
  type        = string
  description = "Azure resource ID to attach diagnostics to"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace ID"
}

variable "log_categories" {
  type        = list(string)
  description = "Diagnostic log categories to enable"
  default     = []
}

variable "metric_categories" {
  type        = list(string)
  description = "Metric categories to enable (often just 'AllMetrics')"
  default     = ["AllMetrics"]
}
