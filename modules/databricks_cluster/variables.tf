variable "cluster_name" {
  type        = string
  description = "Databricks cluster name"
}

variable "autotermination_minutes" {
  type        = number
  description = "Minutes of inactivity before auto-termination"
  default     = 20
}

variable "node_type_id" {
  type        = string
  description = "Databricks node type (e.g., Standard_DS3_v2)"
  default     = "Standard_DS3_v2"
}

variable "num_workers" {
  type        = number
  description = "Number of worker nodes"
  default     = 1
}

variable "spark_version" {
  type        = string
  description = "Databricks runtime version. If empty, latest LTS will be used."
  default     = ""
}

variable "data_security_mode" {
  type        = string
  description = "Cluster security mode (e.g., NONE or SINGLE_USER). Keep simple for portfolio."
  default     = "NONE"
}
