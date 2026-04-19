resource "azurerm_firewall" "firewall" {
  for_each = var.firewall

  name                = each.value.fw_name
  location            = each.value.location
  resource_group_name = each.value.resource_group
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier

  ip_configuration {
    name                 = "${each.value.fw_name}-ipconfig"
    subnet_id            = var.subnet_ids[each.value.subnet_name]
    public_ip_address_id = var.public_ip_ids[each.value.public_ip_name]
  }
}