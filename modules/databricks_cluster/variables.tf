# =============================================================================
# Databricks Cluster Module - Input Variables
# =============================================================================
# Defines configuration parameters for interactive Databricks cluster.
# =============================================================================

variable "cluster_name" {
  type        = string
  description = "Display name for the Databricks cluster"
}

variable "autotermination_minutes" {
  type        = number
  description = <<-EOT
    Minutes of inactivity before the cluster automatically terminates.
    Cost optimization: cluster shuts down when idle to save money.
    Default: 20 minutes
  EOT
  default     = 20
}

variable "node_type_id" {
  type        = string
  description = <<-EOT
    Azure VM size for cluster nodes.
    Examples: Standard_DS3_v2 (dev), Standard_DS4_v2 (production)
  EOT
  default     = "Standard_DS3_v2"
}

variable "num_workers" {
  type        = number
  description = <<-EOT
    Number of worker nodes in the cluster.
    0 = single-node cluster, 1+ = multi-node cluster
  EOT
  default     = 1
}

variable "spark_version" {
  type        = string
  description = <<-EOT
    Databricks runtime version (e.g., '13.3.x-scala2.12').
    If empty string, latest LTS version will be automatically selected.
  EOT
  default     = ""
}

variable "data_security_mode" {
  type        = string
  description = <<-EOT
    Cluster security mode:
    - NONE: No isolation (simplest, for dev/testing)
    - SINGLE_USER: Isolated for one user
    - USER_ISOLATION: Multi-user with isolation (production)
  EOT
  default     = "NONE"
}
