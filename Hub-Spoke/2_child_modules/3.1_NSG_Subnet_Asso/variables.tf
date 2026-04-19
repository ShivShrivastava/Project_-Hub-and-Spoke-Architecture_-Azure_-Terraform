variable "subnet_ids" {
  description = "Map of subnet IDs"
  type        = map(string)
}

variable "nsg_ids" {
  description = "Map of NSG IDs"
  type        = map(string)
}

variable "subnet_nsg_association" {
  description = "Subnet to NSG association"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}
