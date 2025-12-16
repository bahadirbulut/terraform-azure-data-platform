# =============================================================================
# Databricks Secret Scope Module - Outputs
# =============================================================================
# Exposes secret scope information for notebook usage reference.
# =============================================================================

output "scope_name" {
  value       = databricks_secret_scope.kv.name
  description = <<-EOT
    Name of the created secret scope.
    Use in notebooks: dbutils.secrets.get("keyvault", "secret-name")
  EOT
}
