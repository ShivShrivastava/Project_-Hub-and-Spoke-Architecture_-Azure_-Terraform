resource "azurerm_subnet" "subnet" {
  for_each = var.subnet

  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = each.key == "databasesubnet" ? [1] : []
    content {
      name = "mssqlserver-delegation"
      service_delegation {
        name    = "Microsoft.Sql/managedInstances"
        actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    }
  }
}