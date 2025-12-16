# =============================================================================
# Azure Data Platform - Main Configuration
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Company: Nexence CommV
# Purpose: Main Terraform configuration orchestrating all platform resources
#
# This file provisions a complete Azure data platform including:
# - Foundation: Resource Group, Log Analytics, Key Vault
# - Storage: ADLS Gen2 with medallion architecture (bronze/silver/gold)
# - Compute: Azure Databricks workspace (optional cluster/jobs)
# - Security: Managed Identity RBAC, Key Vault secrets
# - Observability: Diagnostic settings for all resources
#
# Architecture: Modular design with reusable components
# Cost Model: Pay-per-use with auto-terminating compute
# =============================================================================

# -----------------------------------------------------------------------------
# Local Variables - Naming and Tagging
# -----------------------------------------------------------------------------
# Standardized naming convention and tags applied to all resources
locals {
  # Name prefix format: {project}-{env} (e.g., nexence-dev)
  name_prefix = "${var.project}-${var.env}"

  # Common tags applied consistently across all resources
  common_tags = merge(
    {
      project    = var.project
      env        = var.env
      owner      = var.owner
      managed_by = "terraform"  # Indicates IaC management
    },
    var.extra_tags  # Allow additional custom tags
  )
}

# -----------------------------------------------------------------------------
# Resource Group - Container for all platform resources
# -----------------------------------------------------------------------------
module "rg" {
  source   = "./modules/resource_group"
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

# -----------------------------------------------------------------------------
# Log Analytics Workspace - Centralized logging and monitoring
# -----------------------------------------------------------------------------
# Receives logs and metrics from all platform resources via diagnostic settings
module "log" {
  source              = "./modules/log_analytics"
  name                = "${local.name_prefix}-log"
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# Azure Key Vault - Centralized secrets management
# -----------------------------------------------------------------------------
# Stores sensitive configuration like storage account names
# Linked to Databricks via secret scope for secure access
module "kv" {
  source              = "./modules/key_vault"
  name                = substr(replace("${local.name_prefix}-kv", "-", ""), 0, 22)  # Max 24 chars, alphanumeric
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# ADLS Gen2 Storage - Data Lake with medallion architecture
# -----------------------------------------------------------------------------
# Hierarchical namespace enabled for big data analytics
# Default containers: bronze (raw), silver (cleansed), gold (aggregated)
module "adls" {
  source              = "./modules/storage_adls"
  name                = lower(replace("${local.name_prefix}adls", "-", ""))  # Lowercase, no hyphens
  location            = var.location
  resource_group_name = module.rg.name
  container_names     = var.adls_container_names
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# Azure Databricks Workspace - Unified analytics platform
# -----------------------------------------------------------------------------
# Premium SKU recommended for production (RBAC, audit logs, compliance)
# Workspace only - no compute costs until cluster provisioned
module "dbx" {
  source              = "./modules/databricks"
  name                = "${local.name_prefix}-dbx"
  location            = var.location
  resource_group_name = module.rg.name
  sku                 = var.databricks_sku
  tags                = local.common_tags
}

# -----------------------------------------------------------------------------
# Managed Identity RBAC - Secure Databricks to ADLS authentication
# -----------------------------------------------------------------------------
# Grant Databricks workspace managed identity access to storage
# Eliminates need for access keys or connection strings
resource "azurerm_role_assignment" "dbx_to_adls" {
  scope                = module.adls.id
  role_definition_name = "Storage Blob Data Contributor"  # Read/write access to blobs
  principal_id         = module.dbx.managed_identity_principal_id
}

# -----------------------------------------------------------------------------
# Key Vault Secret - Store storage account name
# -----------------------------------------------------------------------------
# Accessible via Databricks secret scope for notebooks and jobs
resource "azurerm_key_vault_secret" "storage_account_name" {
  name         = "storage-account-name"
  value        = module.adls.account_name
  key_vault_id = module.kv.id

  depends_on = [
    module.kv
  ]
}

# -----------------------------------------------------------------------------
# Databricks Secret Scope - Link to Key Vault
# -----------------------------------------------------------------------------
# Enables Databricks notebooks to access secrets via dbutils.secrets.get()
# Only created when Databricks compute is enabled (databricks_host != "")
module "dbx_secret_scope" {
  count  = var.databricks_host != "" ? 1 : 0
  source = "./modules/databricks_secret_scope"

  scope_name    = "keyvault"
  key_vault_id  = module.kv.id
  key_vault_uri = module.kv.vault_uri
}

# -----------------------------------------------------------------------------
# Databricks Interactive Cluster - Development and exploration
# -----------------------------------------------------------------------------
# Conditional: Only created when databricks_host is provided
# Auto-terminates after 20 minutes of inactivity to minimize costs
# Suitable for interactive development, not recommended for production ETL
module "dbx_cluster_dev" {
  count  = var.databricks_host != "" ? 1 : 0
  source = "./modules/databricks_cluster"

  cluster_name            = "${local.name_prefix}-cluster"
  autotermination_minutes = 20  # Cost optimization: terminate when idle
  node_type_id            = "Standard_DS3_v2"  # Small VM for dev workloads
  num_workers             = 1  # Single worker for minimal cost
  spark_version           = ""  # Empty string uses LTS version from data source in module
  data_security_mode      = "NONE"  # For dev; use USER_ISOLATION in production
}

# -----------------------------------------------------------------------------
# Databricks Repo - Git integration for notebooks
# -----------------------------------------------------------------------------
# Links this Git repository to Databricks workspace
# Enables version control and CI/CD for notebook development
module "dbx_repo" {
  count  = var.databricks_host != "" ? 1 : 0
  source = "./modules/databricks_repo"

  repo_url  = var.repo_url   # GitHub repository URL
  repo_path = var.repo_path  # Workspace path (e.g., /Repos/<user>/<repo>)
}

# -----------------------------------------------------------------------------
# Databricks Job - Scheduled ETL Pipeline
# -----------------------------------------------------------------------------
# Daily job running medallion architecture: Bronze → Silver → Gold
# Uses ephemeral job cluster (cost-efficient, created on-demand)
# Automatically passes storage account name to all notebook tasks
module "dbx_job_daily_orders" {
  count  = var.databricks_host != "" ? 1 : 0
  source = "./modules/databricks_job"

  repo_base_path       = var.repo_path
  storage_account_name = module.adls.account_name  # Auto-injected to notebooks
  notification_emails  = var.notification_emails   # Alerts on job failure

  node_type_id = "Standard_DS3_v2"  # Job cluster VM type
  num_workers  = 1                  # Single worker for small workloads
}

# =============================================================================
# Diagnostic Settings - Observability and Auditing
# =============================================================================
# All diagnostic settings send logs and metrics to Log Analytics workspace
# for centralized monitoring, alerting, and compliance
# =============================================================================

# -----------------------------------------------------------------------------
# Diagnostics: ADLS Gen2 Storage Account
# -----------------------------------------------------------------------------
# Tracks all storage operations for auditing and troubleshooting
module "diag_adls" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-adls"
  target_resource_id         = module.adls.id
  log_analytics_workspace_id = module.log.workspace_id

  # Storage operation categories
  log_categories = [
    "StorageRead",   # Read operations
    "StorageWrite",  # Write operations
    "StorageDelete"  # Delete operations
  ]

  metric_categories = ["AllMetrics"]  # Performance and capacity metrics
}

# -----------------------------------------------------------------------------
# Diagnostics: Key Vault
# -----------------------------------------------------------------------------
# Audit all secret access for security compliance
module "diag_kv" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-kv"
  target_resource_id         = module.kv.id
  log_analytics_workspace_id = module.log.workspace_id

  log_categories    = ["AuditEvent"]    # Who accessed which secrets when
  metric_categories = ["AllMetrics"]    # Performance metrics
}

# -----------------------------------------------------------------------------
# Diagnostics: Databricks Workspace
# -----------------------------------------------------------------------------
# Monitor cluster activities, job runs, and workspace usage
module "diag_dbx" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-dbx"
  target_resource_id         = module.dbx.id
  log_analytics_workspace_id = module.log.workspace_id

  # Databricks activity categories
  log_categories = [
    "workspace",  # Workspace-level operations
    "clusters",   # Cluster lifecycle events
    "dbfs",       # File system operations
    "jobs"        # Job execution logs
  ]

  metric_categories = ["AllMetrics"]  # Workspace metrics
}
