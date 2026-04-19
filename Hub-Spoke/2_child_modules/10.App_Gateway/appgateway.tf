locals {
  backend_ips = [
    for nic in var.vm_nics["appgw-east"] :
    var.nic_private_ips[nic]
  ]
}

resource "azurerm_application_gateway" "appgateway" {
  for_each = var.appgateway

  name                = each.value.ag_name
  location            = each.value.ag_location
  resource_group_name = each.value.resource_group_name

  sku {
    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.sku_capacity
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_ids[each.value.subnet_name]
  }

  frontend_port {
    name = "${each.value.ag_name}-frontend-port"
    port = each.value.frontend_port
  }

  frontend_ip_configuration {
    name                 = "${each.value.ag_name}-frontend-ip"
    public_ip_address_id = var.public_ip_ids[each.value.public_ip_name]
  }

  backend_address_pool {
    name         = each.value.backend_pool_name
    ip_addresses = local.backend_ips
  }

  backend_http_settings {
    name                  = each.value.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = each.value.listener_name
    frontend_ip_configuration_name = "${each.value.ag_name}-frontend-ip"
    frontend_port_name             = "${each.value.ag_name}-frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = each.value.request_routing_rule_name
    priority                   = 1
    rule_type                  = "Basic"
    http_listener_name         = each.value.listener_name
    backend_address_pool_name  = each.value.backend_pool_name
    backend_http_settings_name = each.value.http_setting_name
  }
}