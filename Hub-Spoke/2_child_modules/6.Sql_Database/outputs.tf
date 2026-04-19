output "sql_server_ids" {
  description = "Map of SQL Server IDs by key"
  value = { for k, v in azurerm_mssql_server.mssql_server : k => v.id }
}