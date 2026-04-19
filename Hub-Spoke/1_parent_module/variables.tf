# ANCHOR: RESOURCE GROUP
variable "resource_group" {
  type = map(object({
    rg_name     = string
    rg_location = string
  }))
}

# ANCHOR: VNET
variable "virtual_network" {
  type = map(object({
    vnet_name           = string
    vnet_location       = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

# ANCHOR: SUBNET
variable "subnet" {
  type = map(object({
    subnet_name          = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}

# ANCHOR: PEERING
variable "peering" {
  description = "VNet peering configuration"
  type = map(object({
    name                = string
    resource_group_name = string
    vnet_name           = string
    remote_vnet_key     = string
  }))
}

# variable "vnet_ids" {
#   description = "Map of VNet IDs coming from VNet module"
#   type        = map(string)
# }

# ANCHOR: VM
variable "linux_virtual_machine" {
  type = map(object({
    vm_name             = string
    resource_group_name = string
    vm_location         = string
    size                = string
    admin_username      = string
    admin_password      = string

    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

# variable "key_vault_ids" {
#   type = map(string)
# }

# variable "nic_ids" {
#   type = map(string)
# }

# ANCHOR: NIC
variable "network_interface" {
  type = map(object({
    vm_name                        = string
    resource_group_name            = string
    vm_location                    = string
    subnet_name                    = string
    private_ip_address_allocation  = string
  }))
}

# GLOBAL SHARED VARIABLES (declared once)

# variable "subnet_ids" {
#   type = map(string)
# }

# variable "public_ip_ids" {
#   type = map(string)
# }

# ANCHOR: SQL
variable "mssql" {
  type = map(object({
    server_name                  = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
    database_name                = string
    collation                    = string
    license_type                 = string
    max_size_gb                  = number
    sku_name                     = string
    enclave_type                 = string
  }))
}

# variable "sql_server_ids" {
#   type = map(string)
# }

# ANCHOR: PRIVATE ENDPOINT
variable "private_endpoints" {
  type = map(object({
    pe_name                         = string
    pe_location                     = string
    resource_group_name             = string
    subnet_name                     = string
    private_connection_name         = string
    private_connection_resource_id  = string
  }))
}

# ANCHOR: BASTION
variable "bastion" {
  type = map(object({
    bastion_name        = string
    bastion_location    = string
    resource_group_name = string
    subnet_name         = string
    public_ip_name      = string
  }))
}

# ANCHOR: PUBLIC IP
variable "pip" {
  type = map(object({
    pip_name            = string
    resource_group_name = string
    pip_location        = string
  }))
}

# ANCHOR: APP GATEWAY
variable "appgateway" {
  type = map(object({
    ag_name                    = string
    ag_location                = string
    resource_group_name        = string
    sku_name                   = string
    sku_tier                   = string
    sku_capacity               = number
    subnet_name                = string
    public_ip_name             = string
    frontend_port              = number
    backend_pool_name          = string
    http_setting_name          = string
    listener_name              = string
    request_routing_rule_name  = string
  }))
}

variable "vm_nics" {
  description = "Map of Application Gateway → list of NIC names"
  type        = map(list(string))
}

# variable "nic_private_ips" {
#   type = map(string)
# }

# ANCHOR: INTERNAL LOAD BALANCER
variable "loadbalancer" {
  type = map(object({
    lb_name              = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    frontend_name        = string
    private_ip_allocation = string
    backend_pool_name    = string
    probe_name           = string
    probe_port           = number
    rule_name            = string
    frontend_port        = number
    backend_port         = number
  }))
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

# ANCHOR: AZURE FIREWALL
variable "firewall" {
  type = map(object({
    fw_name        = string
    resource_group = string
    location       = string
    subnet_name    = string
    public_ip_name = string
    sku_name       = string
    sku_tier       = string
  }))
}

# ANCHOR: ROUTE TABLE
variable "route_tables" {
  type = map(object({
    rt_name          = string
    resource_group_name   = string
    location         = string
    subnet_names     = optional(list(string))   # subnets to associate
    next_hop_ip      = string         # firewall private IP
  }))
}

variable "subnet_route_tables" {}

# variable "firewall_private_ips" {
#   type = map(string)
# }

# ANCHOR: NSG
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

# variable "lb_private_ip" {
#   type        = string
#   description = "Private IP of internal LB to use in NSG rules"
# }

# ANCHOR: NSG + Subnet Association
# variable "nsg_ids" {
#   description = "Map of NSG IDs"
#   type        = map(string)
# }

variable "subnet_nsg_association" {
  description = "Subnet to NSG association"
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

# ANCHOR: KEY VAULT
variable "key_vaults" {
  type = map(object({
    kv_name                     = string
    resource_group_name         = string
    location                    = string
    sku_name                    = string
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    enabled_for_disk_encryption = bool
    spoke_subnet_keys           = list(string)

    network_acls = object({
      default_action = string
      bypass         = string
    })

    access_policies = list(object({
      tenant_id           = string
      object_id           = string
      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    }))
  }))
}

variable "vm_passwords" {
  description = "Map of VM admin passwords per Key Vault"
  type        = map(string)
  sensitive   = true
}