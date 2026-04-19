variable "appgateway" {
  type = map(object({
    ag_name                   = string
    ag_location               = string
    resource_group_name    = string
    sku_name = string
    sku_tier = string
    sku_capacity = number
    subnet_name            = string
    public_ip_name         = string
    frontend_port          = number
    backend_pool_name      = string
    http_setting_name      = string
    listener_name          = string
    request_routing_rule_name = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "public_ip_ids" {
  type = map(string)
}

variable "vm_nics" {
  description = "Map of Application Gateway → list of NIC names"
  type        = map(list(string))
}

variable "nic_private_ips"{
  type = map(string)
}