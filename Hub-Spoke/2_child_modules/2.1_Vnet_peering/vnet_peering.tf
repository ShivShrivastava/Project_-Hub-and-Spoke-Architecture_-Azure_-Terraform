resource "azurerm_virtual_network_peering" "peering" {
  for_each = var.peering

  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.vnet_name
  remote_virtual_network_id = var.vnet_ids[each.value.remote_vnet_key]

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}