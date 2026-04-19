# Azure ILB
resource "azurerm_lb" "ilb" {
  for_each = var.loadbalancer

  name                = each.value.lb_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = each.value.frontend_name
    subnet_id                     = var.subnet_ids[each.value.subnet_name]
    private_ip_address_allocation = each.value.private_ip_allocation
  }
}

# backend_pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each = var.loadbalancer

  name            = each.value.backend_pool_name
  loadbalancer_id = azurerm_lb.ilb[each.key].id
}

# Health probe
resource "azurerm_lb_probe" "probe" {
  for_each = var.loadbalancer

  name            = each.value.probe_name
  loadbalancer_id = azurerm_lb.ilb[each.key].id
  protocol        = "Tcp"
  port            = each.value.probe_port
}

# lb_rule
resource "azurerm_lb_rule" "rule" {
  for_each = var.loadbalancer

  name                           = each.value.rule_name
  loadbalancer_id                = azurerm_lb.ilb[each.key].id
  protocol                       = "Tcp"
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.probe[each.key].id
}

# Backend NIC association
# resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
#   for_each = {
#     for lb_key, nic_list in var.backend_nics :
#     lb_key => nic_list
#   }

#   network_interface_id    = var.nic_ids[each.value.nic]
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.key].id
# }


locals {
  backend_nic_map = flatten([
    for lb_key, nic_list in var.backend_nics : [
      for nic in nic_list : {
        lb_key = lb_key
        nic    = nic
      }
    ]
  ])
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {

  for_each = {
    for item in local.backend_nic_map :
    "${item.lb_key}-${item.nic}" => item
  }

  network_interface_id    = var.nic_ids[each.value.nic]
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.value.lb_key].id
}

