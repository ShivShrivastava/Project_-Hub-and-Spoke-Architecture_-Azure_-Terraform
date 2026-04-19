output "firewall_private_ips" {
  description = "Map of Azure Firewall private IPs by key"
  value = {
    for k, fw in azurerm_firewall.firewall :
    k => fw.ip_configuration[0].private_ip_address
  }
}