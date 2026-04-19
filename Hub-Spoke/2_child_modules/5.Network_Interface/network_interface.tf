resource "azurerm_network_interface" "nic" {
  for_each = var.network_interface

  name                = "${each.value.vm_name}-nic"
  location            = each.value.vm_location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[each.value.subnet_name]
    private_ip_address_allocation = each.value.private_ip_address_allocation
  }
}

