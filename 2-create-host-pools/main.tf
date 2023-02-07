# We are going to create an AVD host pool
locals {
  base_name = "${var.prefix}-W10-WS"
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "base" {
  name     = local.base_name
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "multisession" {
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name

  name                     = local.base_name
  validate_environment     = false
  description              = "Pooled Virtual Desktop Host Pool for hub network"
  type                     = "Pooled"
  load_balancer_type       = "DepthFirst"
  maximum_sessions_allowed = 10

}

resource "azurerm_virtual_desktop_workspace" "multisession" {
  name                = "${local.base_name}-westus"
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name
}

resource "azurerm_virtual_desktop_application_group" "desktopapp" {
  name                = "${local.base_name}-DAG"
  location            = azurerm_resource_group.base.location
  resource_group_name = azurerm_resource_group.base.name

  type         = "Desktop"
  host_pool_id = azurerm_virtual_desktop_host_pool.multisession.id
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "desktopapp" {
  workspace_id         = azurerm_virtual_desktop_workspace.multisession.id
  application_group_id = azurerm_virtual_desktop_application_group.desktopapp.id
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "multisession" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.multisession.id
  expiration_date = timeadd(timestamp(), "24h")
}