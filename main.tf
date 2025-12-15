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
