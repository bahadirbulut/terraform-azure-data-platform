# =============================================================================
# Databricks Workspace Module - Input Variables
# =============================================================================
# Defines configuration parameters for Azure Databricks workspace.
# =============================================================================

variable "name" {
  type        = string
  description = "Name of the Databricks workspace"
}

variable "location" {
  type        = string
  description = "Azure region for the Databricks workspace"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the workspace will be created"
}

variable "sku" {
  type        = string
  description = <<-EOT
    Databricks SKU tier: 'standard' or 'premium'.
    Premium recommended for production (includes RBAC, audit logs, compliance features).
  EOT
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Databricks workspace"
}
