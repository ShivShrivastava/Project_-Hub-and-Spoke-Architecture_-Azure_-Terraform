variable "loadbalancer" {
  type = map(object({
    lb_name             = string
    location            = string
    resource_group_name = string
    subnet_name         = string
    frontend_name       = string
    private_ip_allocation = string
    backend_pool_name   = string
    probe_name          = string
    probe_port          = number
    rule_name           = string
    frontend_port       = number
    backend_port        = number
  }))
}

variable "subnet_ids" {
  type = map(string)
}

# variable "backend_nics" {
#   description = "Map of backend VM NIC lists"
#   type = map(object({
#     nic = list(string)
#   }))
# }

variable "backend_nics" {
  type = map(list(string))
}

variable "nic_ids" {
  type = map(string)
}