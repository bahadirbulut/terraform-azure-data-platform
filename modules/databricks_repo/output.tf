# =============================================================================
# Databricks Repo Module - Outputs
# =============================================================================
# Exposes repository information for use by other modules or configurations.
# =============================================================================

# -----------------------------------------------------------------------------
# Repository Path
# -----------------------------------------------------------------------------
output "path" {
  value       = databricks_repo.this.path
  description = <<-EOT
    Workspace path where the Git repository is mounted.
    Use this path to reference notebooks in job configurations.
    
    Example usage in notebook path:
    "${module.dbx_repo.path}/databricks/notebooks/01_bronze_ingest.py"
  EOT
}
