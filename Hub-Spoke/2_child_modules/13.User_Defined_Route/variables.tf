variable "route_tables" {
  type = map(object({
    rt_name          = string
    resource_group_name   = string
    location         = string
    subnet_names     = optional(list(string))   # subnets to associate
    next_hop_ip      = string         # firewall private IP
  }))
}

variable "firewall_private_ips" {
   type        = map(string)
}

variable "subnet_ids" {
  type = map(string)
}

variable "subnet_route_tables" {}