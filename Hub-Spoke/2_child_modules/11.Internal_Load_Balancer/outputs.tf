output "private_ip" {
  description = "Private IP of the internal Load Balancer"
  value       = azurerm_lb.ilb[keys(var.loadbalancer)[0]].frontend_ip_configuration[0].private_ip_address
}