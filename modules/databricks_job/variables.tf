variable "repo_base_path" {
  type        = string
  description = "Databricks Repo base path, e.g. /Repos/<user>/terraform-azure-data-platform"
}

variable "storage_account_name" {
  type        = string
  description = "ADLS Gen2 storage account name for notebook parameters"
  default     = ""
}

variable "node_type_id" {
  type        = string
  description = "Databricks node type"
  default     = "Standard_DS3_v2"
}

variable "num_workers" {
  type        = number
  description = "Number of worker nodes"
  default     = 1
}

variable "notification_emails" {
  type        = list(string)
  description = "Email addresses to notify on job failure"
  default     = []
}
