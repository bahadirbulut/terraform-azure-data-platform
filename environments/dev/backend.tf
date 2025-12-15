terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "nexencetfstate123"
    container_name       = "tfstate"
    key                  = "terraform-azure-data-platform/dev.tfstate"
  }
}
