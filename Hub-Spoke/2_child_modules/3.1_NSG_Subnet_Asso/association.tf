resource "azurerm_subnet_network_security_group_association" "association" {
  for_each = var.subnet_nsg_association

  subnet_id                 = var.subnet_ids[each.value.subnet_key]
  network_security_group_id = var.nsg_ids[each.value.nsg_key]
}