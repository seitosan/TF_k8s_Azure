#Deploy ressource group for hub and spoke typologie
resource "azurerm_resource_group" "hub" {
  name     = var.vnet_resource_group_name
  location = var.location
}

resource "azurerm_resource_group" "spoke" {
  name     = var.kube_resource_group_name
  location = var.location
}
