# =============================================================================
# ADLS Gen2 Storage Account Module
# =============================================================================
# Purpose: Create Azure Data Lake Storage Gen2 with medallion architecture
#
# Features:
# - Hierarchical namespace enabled for big data analytics
# - TLS 1.2 minimum for security
# - Private containers (no public access)
# - LRS replication for cost efficiency
# =============================================================================

variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "container_names" { type = list(string) }
variable "tags" { type = map(string) }

# Storage Account with Data Lake capabilities
resource "azurerm_storage_account" "this" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name

  account_tier             = "Standard"        # Standard performance tier
  account_replication_type = "LRS"             # Locally-redundant storage
  account_kind             = "StorageV2"       # General purpose v2

  is_hns_enabled           = true              # CRITICAL: Enables ADLS Gen2

  min_tls_version          = "TLS1_2"          # Security: minimum TLS version
  allow_nested_items_to_be_public = false      # Security: prevent public access

  tags = var.tags
}

# Create containers for medallion architecture (bronze, silver, gold)
resource "azurerm_storage_container" "containers" {
  for_each              = toset(var.container_names)
  name                  = each.value
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"  # No anonymous access
}
