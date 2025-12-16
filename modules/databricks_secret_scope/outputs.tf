output "scope_name" {
  value       = databricks_secret_scope.kv.name
  description = "Name of the created secret scope"
}
