resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion

  name                = each.value.bastion_name
  location            = each.value.bastion_location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_ids[each.value.subnet_name]
    public_ip_address_id = var.public_ip_ids[each.value.public_ip_name]
  }
}