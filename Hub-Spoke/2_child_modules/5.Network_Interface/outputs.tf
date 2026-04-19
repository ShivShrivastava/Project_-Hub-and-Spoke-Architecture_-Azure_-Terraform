output "nic_ids" {
  description = "Map of NIC IDs by key"
  value = { for k, v in azurerm_network_interface.nic : k => v.id }
}

output "nic_private_ips" {
  description = "Map of NIC private IPs by key"
  value = { for k, v in azurerm_network_interface.nic : k => v.ip_configuration[0].private_ip_address }
}

# output "nic_private_ips" {
#   description = "Map of NIC private IPs by key"
#   value = {
#     for k, v in azurerm_network_interface.nic :
#     k => v.ip_configuration[0].private_ip_address
#   }
# }


