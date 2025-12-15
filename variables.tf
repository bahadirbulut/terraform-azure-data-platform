variable "project" {
  type        = string
  description = "Short project name, e.g. nexence or demo"
}

variable "env" {
  type        = string
  description = "Environment name, e.g. dev, prod"
}

variable "owner" {
  type        = string
  description = "Owner tag (name or team)"
}

variable "location" {
  type        = string
  description = "Azure region, e.g. westeurope"
  default     = "westeurope"
}

variable "extra_tags" {
  type        = map(string)
  description = "Additional tags"
  default     = {}
}

variable "adls_container_names" {
  type        = list(string)
  description = "List of ADLS Gen2 containers"
  default     = ["bronze", "silver", "gold"]
}

variable "databricks_sku" {
  type        = string
  description = "Databricks SKU, usually 'standard' or 'premium'"
  default     = "premium"
}
