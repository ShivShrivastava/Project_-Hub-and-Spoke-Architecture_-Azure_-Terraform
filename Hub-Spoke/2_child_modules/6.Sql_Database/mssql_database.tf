resource "azurerm_mssql_server" "mssql_server" {
  for_each = var.mssql
  name                         = each.value.server_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
}

resource "azurerm_mssql_database" "mssql_database" {
  for_each = var.mssql
  name         = each.value.database_name
  server_id    = azurerm_mssql_server.mssql_server[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  lifecycle {
    prevent_destroy = true
  }
}