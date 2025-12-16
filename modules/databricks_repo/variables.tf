# =============================================================================
# Databricks Repo Module - Input Variables
# =============================================================================
# Defines configuration parameters for linking Git repositories to Databricks.
# =============================================================================

# -----------------------------------------------------------------------------
# Repository URL
# -----------------------------------------------------------------------------
variable "repo_url" {
  type        = string
  description = <<-EOT
    Git repository URL for Databricks Repos integration.
    Must be HTTPS URL ending with .git for proper recognition.
    Supports: GitHub, GitLab, Bitbucket, Azure DevOps.
    
    Example: https://github.com/username/repo-name.git
  EOT
  default     = "https://github.com/bahadirbulut/terraform-azure-data-platform.git"
}

# -----------------------------------------------------------------------------
# Repository Workspace Path
# -----------------------------------------------------------------------------
variable "repo_path" {
  type        = string
  description = <<-EOT
    Databricks workspace path where the repository will be mounted.
    Format: /Repos/<username>/<repository-name>
    
    This path determines where notebooks from the repo will be accessible
    within the Databricks workspace file system.
    
    Example: /Repos/bahadir.bulut@nexence.be/terraform-azure-data-platform
  EOT
  default     = "/Repos/bahadirbulut/terraform-azure-data-platform"
}
