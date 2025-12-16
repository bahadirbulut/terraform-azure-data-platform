resource "databricks_repo" "this" {
  url  = var.repo_url
  path = var.repo_path
}
