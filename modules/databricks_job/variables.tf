# =============================================================================
# Databricks Job Module - Input Variables
# =============================================================================
# Defines configuration for scheduled ETL job with medallion architecture.
# =============================================================================

variable "repo_base_path" {
  type        = string
  description = <<-EOT
    Databricks Repo base path where notebooks are located.
    Example: /Repos/user@company.com/terraform-azure-data-platform
    Notebooks are referenced relative to this path.
  EOT
}

variable "storage_account_name" {
  type        = string
  description = <<-EOT
    ADLS Gen2 storage account name.
    Passed as a parameter to all notebook tasks for data access.
  EOT
  default     = ""
}

variable "node_type_id" {
  type        = string
  description = <<-EOT
    Azure VM size for job cluster nodes.
    Example: Standard_DS3_v2 (cost-efficient for small workloads)
  EOT
  default     = "Standard_DS3_v2"
}

variable "num_workers" {
  type        = number
  description = <<-EOT
    Number of worker nodes in the job cluster.
    1 = minimal cluster for dev/testing
  EOT
  default     = 1
}

variable "notification_emails" {
  type        = list(string)
  description = <<-EOT
    Email addresses to notify on job failure.
    Alerts are sent when tasks fail or timeout.
  EOT
  default     = []
}
