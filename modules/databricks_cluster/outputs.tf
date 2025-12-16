# =============================================================================
# Databricks Cluster Module - Outputs
# =============================================================================
# Exposes cluster information for reference and automation.
# =============================================================================

output "cluster_id" {
  value       = databricks_cluster.this.id
  description = "Unique identifier of the created Databricks cluster"
}
