# =============================================================================
# Databricks Interactive Cluster Module
# =============================================================================
# Purpose: Create auto-terminating cluster for development and exploration
#
# Features:
# - Auto-termination for cost optimization
# - Latest LTS Spark version by default
# - Configurable VM size and worker count
# =============================================================================

# Get latest Long-Term Support (LTS) Spark version
data "databricks_spark_version" "lts" {
  long_term_support = true
}

# Interactive cluster for development
resource "databricks_cluster" "this" {
  cluster_name = var.cluster_name

  # Use provided Spark version or default to LTS
  spark_version = (
    var.spark_version != ""
    ? var.spark_version
    : data.databricks_spark_version.lts.id  # Latest LTS if not specified
  )

  node_type_id            = var.node_type_id              # VM size (e.g., Standard_DS3_v2)
  num_workers             = var.num_workers               # Number of worker nodes
  autotermination_minutes = var.autotermination_minutes   # Auto-shutdown when idle

  # Portfolio setting: simplified for development
  # For production: use USER_ISOLATION or SINGLE_USER
  data_security_mode = var.data_security_mode
}
