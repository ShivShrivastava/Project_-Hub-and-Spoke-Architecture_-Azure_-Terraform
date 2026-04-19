variable "network_interface" {
  type = map(object({
    vm_name                   = string
    resource_group_name       = string
    vm_location               = string
    subnet_name                 = string
    private_ip_address_allocation = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}