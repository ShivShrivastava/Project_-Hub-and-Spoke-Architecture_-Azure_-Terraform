resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_network

  name                = each.value.vnet_name
  location            = each.value.vnet_location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}