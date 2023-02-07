output "token" {
  value = nonsensitive(azurerm_virtual_desktop_host_pool_registration_info.multisession.token)
}

output "resource_group_name" {
  value = azurerm_resource_group.base.name
}

output "host_pool_name" {
  value = azurerm_virtual_desktop_host_pool.multisession.name
}