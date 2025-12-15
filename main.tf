locals {
  name_prefix = "${var.project}-${var.env}"

  common_tags = merge(
    {
      project    = var.project
      env        = var.env
      owner      = var.owner
      managed_by = "terraform"
    },
    var.extra_tags
  )
}

module "rg" {
  source   = "./modules/resource_group"
  name     = "${local.name_prefix}-rg"
  location = var.location
  tags     = local.common_tags
}

module "log" {
  source              = "./modules/log_analytics"
  name                = "${local.name_prefix}-log"
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

module "kv" {
  source              = "./modules/key_vault"
  name                = substr(replace("${local.name_prefix}-kv", "-", ""), 0, 22)
  location            = var.location
  resource_group_name = module.rg.name
  tags                = local.common_tags
}

module "adls" {
  source              = "./modules/storage_adls"
  name                = lower(replace("${local.name_prefix}adls", "-", ""))
  location            = var.location
  resource_group_name = module.rg.name
  container_names     = var.adls_container_names
  tags                = local.common_tags
}

module "dbx" {
  source              = "./modules/databricks"
  name                = "${local.name_prefix}-dbx"
  location            = var.location
  resource_group_name = module.rg.name
  sku                 = var.databricks_sku
  tags                = local.common_tags
}

module "dbx_cluster_dev" {
  count  = var.databricks_host != "" ? 1 : 0
  source = "./modules/databricks_cluster"

  cluster_name            = "${local.name_prefix}-cluster"
  autotermination_minutes = 20
  node_type_id            = "Standard_DS3_v2"
  num_workers             = 1
  spark_version           = ""
  data_security_mode      = "NONE"
}

# Diagnostics: Storage Account (ADLS Gen2)
module "diag_adls" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-adls"
  target_resource_id         = module.adls.id
  log_analytics_workspace_id = module.log.workspace_id

  # Common useful categories for Storage Account diagnostics
  log_categories = [
    "StorageRead",
    "StorageWrite",
    "StorageDelete"
  ]

  metric_categories = ["AllMetrics"]
}

# Diagnostics: Key Vault
module "diag_kv" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-kv"
  target_resource_id         = module.kv.id
  log_analytics_workspace_id = module.log.workspace_id

  log_categories   = ["AuditEvent"]
  metric_categories = ["AllMetrics"]
}

# Diagnostics: Databricks Workspace
module "diag_dbx" {
  source                     = "./modules/diagnostics"
  name                       = "${local.name_prefix}-diag-dbx"
  target_resource_id         = module.dbx.id
  log_analytics_workspace_id = module.log.workspace_id

  # Databricks categories can vary by workspace/region/features.
  # We'll start with common ones and adjust if Azure rejects any category.
  log_categories = [
    "workspace",
    "clusters",
    "dbfs",
    "jobs"
  ]

  metric_categories = ["AllMetrics"]
}
