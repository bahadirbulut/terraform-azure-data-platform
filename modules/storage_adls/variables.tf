variable "name" {
  type        = string
  description = "Name of the Storage Account (must be globally unique, lowercase, 3–24 chars)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the storage account is created"
}

variable "container_names" {
  type        = list(string)
  description = "List of ADLS Gen2 containers (e.g. bronze, silver, gold)"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the storage account"
}
