# Provider initialization
provider "azurerm" {
  features {}
}

# We are going to create storage for an AVD host pool
locals {
  base_name    = "${var.prefix}-msix"
  storage_name = "${lower(var.prefix)}msix${random_string.storage_name.result}"
  group_name   = "msix-users"
}

# Create a random storage account name
resource "random_string" "storage_name" {
  length  = 6
  special = false
  upper   = false
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "base" {
  name     = local.base_name
  location = var.location
}

resource "azurerm_storage_account" "base" {
  name                     = local.storage_name
  resource_group_name      = azurerm_resource_group.base.name
  location                 = azurerm_resource_group.base.location
  account_tier             = "Premium"
  account_kind             = "FileStorage"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "base" {
  name                 = "msix-apps"
  storage_account_name = azurerm_storage_account.base.name
  quota                = 100
}
