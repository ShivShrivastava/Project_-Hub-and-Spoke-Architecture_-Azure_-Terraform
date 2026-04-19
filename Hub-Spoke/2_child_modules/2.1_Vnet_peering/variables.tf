variable "peering" {
  description = "VNet peering configuration"
  type = map(object({
    name                 = string
    resource_group_name  = string
    vnet_name            = string
    remote_vnet_key      = string
  }))
}

variable "vnet_ids" {
  description = "Map of VNet IDs coming from VNet module"
  type        = map(string)
}