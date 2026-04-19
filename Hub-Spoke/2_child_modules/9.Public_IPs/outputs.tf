output "public_ip_ids" {
  description = "Map of Public IP IDs by key"
  value = { for k, v in azurerm_public_ip.pip : k => v.id }
}