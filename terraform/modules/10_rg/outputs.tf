output "rg_hubname" {
    value = azurerm_resource_group.hub.name
}
output "rg_spokename" {
  value = azurerm_resource_group.spoke.name
}
output "rg_region" {
  value = azurerm_resource_group.hub.location
}