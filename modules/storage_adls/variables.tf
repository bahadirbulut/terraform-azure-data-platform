# =============================================================================
# ADLS Gen2 Storage Module - Input Variables
# =============================================================================
# Defines configuration parameters for Data Lake Storage.
# =============================================================================

variable "name" {
  type        = string
  description = <<-EOT
    Name of the Storage Account.
    Must be globally unique, lowercase, alphanumeric, 3-24 characters.
    Example: myprojectdevadls
  EOT
}

variable "location" {
  type        = string
  description = "Azure region for the storage account"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the storage account will be created"
}

variable "container_names" {
  type        = list(string)
  description = <<-EOT
    List of ADLS Gen2 containers to create.
    Default: ["bronze", "silver", "gold"] for medallion architecture.
    Bronze = raw data, Silver = cleansed, Gold = aggregated.
  EOT
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the storage account"
}
