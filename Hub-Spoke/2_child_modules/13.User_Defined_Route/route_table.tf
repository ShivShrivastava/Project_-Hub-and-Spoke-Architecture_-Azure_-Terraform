resource "azurerm_route_table" "rt" {
  for_each = var.route_tables

  name                = each.value.rt_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
}

resource "azurerm_route" "rt_internet" {
  for_each = var.route_tables

  name                   = "route-to-internet"
  resource_group_name    = each.value.resource_group_name
  route_table_name       = azurerm_route_table.rt[each.key].name
  address_prefix         = "0.0.0.0/0"                  # internet
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ips[each.value.next_hop_ip]      # firewall private IP
}

resource "azurerm_subnet_route_table_association" "rt_assoc" {

  for_each = var.subnet_route_tables

  subnet_id      = var.subnet_ids[each.key]
  route_table_id = azurerm_route_table.rt[each.value].id
}


