variable "bastion" {
  type = map(object({
    bastion_name          = string
    bastion_location      = string
    resource_group_name   = string
    subnet_name           = string
    public_ip_name        = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "public_ip_ids" {
  type = map(string)
}