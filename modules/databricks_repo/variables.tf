variable "repo_url" {
  type        = string
  description = "Git repository URL for Databricks Repos"
  default     = "https://github.com/bahadirbulut/terraform-azure-data-platform.git"
}

variable "repo_path" {
  type        = string
  description = "Databricks workspace repo path"
  default     = "/Repos/bahadirbulut/terraform-azure-data-platform"
}
