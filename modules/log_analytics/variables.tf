# =============================================================================
# Log Analytics Workspace Module - Input Variables
# =============================================================================
# Defines configuration parameters for Log Analytics workspace.
# =============================================================================

variable "name" {
  type        = string
  description = "Name of the Log Analytics workspace"
}

variable "location" {
  type        = string
  description = "Azure region for the workspace"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the workspace is created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the workspace"
}
