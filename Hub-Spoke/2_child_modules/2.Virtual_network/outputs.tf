output "vnet_ids" {
  description = "Map of VNet IDs"
  value = {
    for key, vnet in azurerm_virtual_network.vnet : key => vnet.id
  }
}