resource "azurerm_private_endpoint" "db_pe" {
  for_each = var.private_endpoints

  name                = each.value.pe_name
  location            = each.value.pe_location
  resource_group_name = each.value.resource_group_name
  subnet_id           = var.subnet_ids[each.value.subnet_name]

  private_service_connection {
    name                           = each.value.private_connection_name
    private_connection_resource_id = var.sql_server_ids[each.value.private_connection_resource_id]
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]  # SQL DB/Server ke liye
  }
}