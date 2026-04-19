variable "virtual_network" {
  type = map(object({
    vnet_name           = string
    vnet_location       = string
    resource_group_name = string
    address_space       = list(string)
  }))
}