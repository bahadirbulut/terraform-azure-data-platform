# =============================================================================
# Terraform Variables - Platform Configuration
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Define all configurable parameters for the Azure data platform
#
# Usage: Set values in terraform.tfvars (copy from terraform.tfvars.example)
# =============================================================================

# -----------------------------------------------------------------------------
# Core Project Variables
# -----------------------------------------------------------------------------
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

variable "databricks_host" {
  type        = string
  description = "Databricks workspace URL (e.g., https://adb-xxxx.azuredatabricks.net). Leave empty to skip Databricks resources in v1."
  default     = ""
}

variable "repo_url" {
  type        = string
  description = "Git repo URL for Databricks Repos"
  default     = ""
}

variable "repo_path" {
  type        = string
  description = "Databricks workspace repo path"
  default     = ""
}

variable "notification_emails" {
  type        = list(string)
  description = "List of email addresses for Databricks job failure notifications"
  default     = []
}

