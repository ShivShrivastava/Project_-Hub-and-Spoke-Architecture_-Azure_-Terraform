variable "firewall" {
  type = map(object({
    fw_name           = string
    resource_group    = string
    location          = string
    subnet_name         = string
    public_ip_name      = string
    sku_name          = string
    sku_tier          = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "public_ip_ids" {
   type = map(string)
}
