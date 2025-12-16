# =============================================================================
# Resource Group Module - Input Variables
# =============================================================================
# Defines parameters for Azure Resource Group creation.
# =============================================================================

variable "name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region (e.g., westeurope, eastus)"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the resource group"
}
