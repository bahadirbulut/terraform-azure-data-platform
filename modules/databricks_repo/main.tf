# =============================================================================
# Databricks Repo Module - Git Integration
# =============================================================================
# Purpose: Links a Git repository to Databricks workspace for version control
#          of notebooks and enables CI/CD workflows.
#
# Features:
# - Clones external Git repository into Databricks workspace
# - Enables notebook version control and collaboration
# - Supports GitHub, GitLab, Bitbucket, Azure DevOps
# - Auto-sync capabilities for continuous deployment
#
# Usage: Notebooks in the repo become accessible in the workspace at the
#        specified path and can be executed by clusters and jobs.
# =============================================================================

# -----------------------------------------------------------------------------
# Databricks Repository Resource
# -----------------------------------------------------------------------------
# Creates a Git repository connection in the Databricks workspace.
# The repository is cloned and kept in sync with the specified branch.
resource "databricks_repo" "this" {
  url  = var.repo_url   # Git repository HTTPS URL (must end with .git)
  path = var.repo_path  # Workspace path where repo will be mounted
}
