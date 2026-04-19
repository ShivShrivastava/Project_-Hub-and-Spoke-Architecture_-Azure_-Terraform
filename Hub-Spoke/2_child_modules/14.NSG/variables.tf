variable "nsg" {
  description = "Map of Network Security Groups with their rules"
  type = map(object({
    nsg_name       = string
    resource_group = string
    location       = string
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "lb_private_ip" {
  type        = string
  description = "Private IP of internal LB to use in NSG rules"
}