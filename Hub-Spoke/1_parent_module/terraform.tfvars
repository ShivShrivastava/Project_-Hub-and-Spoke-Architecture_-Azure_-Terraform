# ANCHOR: RESOURCE GROUP
resource_group = {
  rg1 = {
    rg_name     = "hubspokerg"
    rg_location = "eastus"
  }
}

# ANCHOR: VNET
virtual_network = {
  hub = {
    vnet_name           = "hubvnet"
    vnet_location       = "eastus"
    resource_group_name = "hubspokerg"
    address_space       = ["10.0.0.0/24"]
    # Azure default DNS IP is 168.63.129.16 (managed internally by Azure).
  }

  spoke = {
    vnet_name           = "spokevnet"
    vnet_location       = "eastus"
    resource_group_name = "hubspokerg"
    address_space       = ["10.1.0.0/24"]
    # Azure default DNS IP is 168.63.129.16 (managed internally by Azure).
  }
}

# ANCHOR: SUBNET
subnet = {
  bastion = {
    subnet_name          = "AzureBastionSubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "hubvnet"
    address_prefixes     = ["10.0.0.0/26"]
  }

  firewall = {
    subnet_name          = "AzureFirewallSubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "hubvnet"
    address_prefixes     = ["10.0.0.64/26"]
  }

  appgateway = {
    subnet_name          = "AppGatewaySubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "hubvnet"
    address_prefixes     = ["10.0.0.128/27"]
  }

  fesubnet = {
    subnet_name          = "frontendvmsubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "spokevnet"
    address_prefixes     = ["10.1.0.0/27"]
  }

  besubnet = {
    subnet_name          = "backendvmsubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "spokevnet"
    address_prefixes     = ["10.1.0.32/27"]
  }

  dbsubnet = {
    subnet_name          = "databasesubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "spokevnet"
    address_prefixes     = ["10.1.0.64/27"]
  }

  pe-subnet = {
    subnet_name          = "privateendpointsubnet"
    resource_group_name  = "hubspokerg"
    virtual_network_name = "spokevnet"
    address_prefixes     = ["10.1.0.96/27"]
  }
}

# ANCHOR: VM
linux_virtual_machine = {
  fevm1 = {
    vm_name             = "fevm1"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    size                = "Standard_B2ats_v2"
    admin_username      = "adminuser"
    admin_password      = "useradmin@123"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }

  fevm2 = {
    vm_name             = "fevm2"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    size                = "Standard_B2ats_v2"
    admin_username      = "adminuser"
    admin_password      = "useradmin@123"

    os_disk = {
      caching              = "ReadOnly"
      storage_account_type = "Standard_LRS"
    }

    source_image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }

  bevm1 = {
    vm_name             = "bevm1"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    size                = "Standard_B2ats_v2"
    admin_username      = "adminuser"
    admin_password      = "useradmin@123"

    os_disk = {
      caching              = "ReadOnly"
      storage_account_type = "Standard_LRS"
    }

    source_image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }

  bevm2 = {
    vm_name             = "bevm2"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    size                = "Standard_B2ats_v2"
    admin_username      = "adminuser"
    admin_password      = "useradmin@123"

    os_disk = {
      caching              = "ReadOnly"
      storage_account_type = "Standard_LRS"
    }

    source_image = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

# ANCHOR: NIC
network_interface = {

  fevm1 = {
    vm_name                       = "fevm1"
    resource_group_name           = "hubspokerg"
    vm_location                   = "eastus"
    subnet_name                   = "frontendvmsubnet"
    private_ip_address_allocation = "Dynamic"
  }

  fevm2 = {
    vm_name                       = "fevm2"
    resource_group_name           = "hubspokerg"
    vm_location                   = "eastus"
    subnet_name                   = "frontendvmsubnet"
    private_ip_address_allocation = "Dynamic"
  }

  bevm1 = {
    vm_name                       = "bevm1"
    resource_group_name           = "hubspokerg"
    vm_location                   = "eastus"
    subnet_name                   = "backendvmsubnet"
    private_ip_address_allocation = "Dynamic"
  }

  bevm2 = {
    vm_name                       = "bevm2"
    resource_group_name           = "hubspokerg"
    vm_location                   = "eastus"
    subnet_name                   = "backendvmsubnet"
    private_ip_address_allocation = "Dynamic"
  }
}

# ANCHOR: SQL
mssql = {

  sqlserver1 = {
    server_name                  = "dbsqlserver"
    resource_group_name          = "hubspokerg"
    location                     = "eastus"
    version                      = "12.0"
    administrator_login          = "sqladmin"
    administrator_login_password = "Password@123"

    database_name = "appdb"
    collation     = "SQL_Latin1_General_CP1_CI_AS"
    license_type  = "LicenseIncluded"
    max_size_gb   = 2
    sku_name      = "S0"
    enclave_type  = "VBS"
  }
}

# ANCHOR: PRIVATE ENDPOINT
private_endpoints = {
  db-sql-pe = {
    pe_name                        = "db-sql-pe"
    pe_location                    = "eastus"
    resource_group_name            = "hubspokerg"
    subnet_name                    = "databasesubnet"
    private_connection_name        = "db-sql-psc"
    private_connection_resource_id = "sqlserver1" # key of mssql module
  }
}

# ANCHOR: BASTION
bastion = {

  bastion = {
    bastion_name        = "bastion"
    bastion_location    = "eastus"
    resource_group_name = "hubspokerg"
    subnet_name         = "AzureBastionSubnet"
    public_ip_name      = "bastion-pip"
  }
}

# ANCHOR: PUBLIC IP
pip = {

  bastion-pip = {
    pip_name            = "bastion-pip"
    resource_group_name = "hubspokerg"
    pip_location        = "eastus"
  }

  appgateway-pip = {
    pip_name            = "appgateway-pip"
    resource_group_name = "hubspokerg"
    pip_location        = "eastus"
  }
  firewall-pip = {
    pip_name            = "firewall-pip"
    resource_group_name = "hubspokerg"
    pip_location        = "eastus"
  }
}

# ANCHOR: APP GATEWAY
appgateway = {

  appgw-east = {
    ag_name                   = "hubappgw"
    ag_location               = "eastus"
    resource_group_name       = "hubspokerg"
    sku_name                  = "Standard_v2"
    sku_tier                  = "Standard_v2"
    sku_capacity              = 2
    subnet_name               = "AppGatewaySubnet"
    public_ip_name            = "appgateway-pip"
    frontend_port             = 80
    backend_pool_name         = "backend-pool-east"
    http_setting_name         = "http-setting-east"
    listener_name             = "listener-east"
    request_routing_rule_name = "rule-east"
  }
}

# vm_nics = {
#   appgw-east = ["fevm1-nic", "fevm2-nic"]
# }

vm_nics = {
  appgw-east = ["fevm1", "fevm2"]
}

# nic_private_ips = {
#   fevm1-nic = "10.0.1.4"
#   fevm2-nic = "10.0.1.5"
# }

# ANCHOR: INTERNAL LOAD BALANCER
loadbalancer = {
  ilb1 = {
    lb_name               = "internal-ilb"
    location              = "eastus"
    resource_group_name   = "hubspokerg"
    subnet_name           = "backendvmsubnet"
    frontend_name         = "internal-frontend"
    private_ip_allocation = "Dynamic"
    backend_pool_name     = "backend-pool"
    probe_name            = "tcp-probe"
    probe_port            = 80
    rule_name             = "http-rule"
    frontend_port         = 80
    backend_port          = 80
  }
}

# backend_nics = {
#   ilb1 = {
#     nic = ["bevm1-nic", "bevm2-nic"]
#   }
# }

# backend_nics = {
#   ilb1 = ["bevm1-nic", "bevm2-nic"]
# }

backend_nics = {
  ilb1 = ["bevm1", "bevm2"]
}

# ANCHOR: AZURE FIREWALL
firewall = {
  hubfw = {
    fw_name        = "hubvnet-fw"
    resource_group = "hubspokerg"
    location       = "eastus"
    subnet_name    = "AzureFirewallSubnet"
    public_ip_name = "firewall-pip"
    sku_name       = "AZFW_VNet"
    sku_tier       = "Standard"
  }
}

# ANCHOR: ROUTE TABLE
route_tables = {
  hubfw-rt = {
    rt_name             = "hub-fw-rt"
    resource_group_name = "hubspokerg"
    location            = "eastus"
    # subnet_names        = ["frontend-subnet", "backend-subnet"]
    next_hop_ip         = "hubfw" # var.firewall_private_ips["hubfw"] = "10.0.255.4"
  }
}

# subnet_route_tables = {
#   fesubnet = "hubfw-rt"
#   besubnet = "hubfw-rt"
# }

subnet_route_tables = {
  frontendvmsubnet = "hubfw-rt"
  backendvmsubnet  = "hubfw-rt"
}

# ANCHOR: NSG
# All NSG rules grouped per subnet
nsg = {
  "frontend-nsg" = {
    nsg_name       = "frontend-nsg"
    location       = "eastus"
    resource_group = "hubspokerg"

    security_rules = {
      Allow-AppGateway-HTTP-HTTPS = {
        name                       = "Allow-AppGateway-HTTP-HTTPS"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.0.0.128/27"
        destination_address_prefix = "10.1.0.0/27"
        source_port_range          = "*"
        destination_port_range     = "80,443"
      }

      Allow-Bastion-SSH = {
        name                       = "Allow-Bastion-SSH"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.0.0.0/26"
        destination_address_prefix = "10.1.0.0/27"
        source_port_range          = "*"
        destination_port_range     = "22"
      }

      Outbound-HTTP-LB = {
        name                       = "Outbound-HTTP-LB"
        priority                   = 120
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.1.0.0/27"
        destination_address_prefix = "*"
        source_port_range          = "*"
        destination_port_range     = "80"
      }
    }
  }

  "backend-nsg" = {
    nsg_name       = "backend-nsg"
    location       = "eastus"
    resource_group = "hubspokerg"

    security_rules = {
      Allow-Frontend-HTTP = {
        name                       = "Allow-Frontend-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.1.0.0/27"
        destination_address_prefix = "10.1.0.32/27"
        source_port_range          = "*"
        destination_port_range     = "80"
      }

      Allow-Bastion-SSH = {
        name                       = "Allow-Bastion-SSH"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.0.0.0/26"
        destination_address_prefix = "10.1.0.32/27"
        source_port_range          = "*"
        destination_port_range     = "22"
      }

      Outbound-DB = {
        name                       = "Outbound-DB"
        priority                   = 130
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.1.0.32/27"
        destination_address_prefix = "10.1.0.64/27"
        source_port_range          = "*"
        destination_port_range     = "1433"
      }
    }
  }

  "database-nsg" = {
    nsg_name       = "database-nsg"
    location       = "eastus"
    resource_group = "hubspokerg"

    security_rules = {
      Allow-Backend-SQL = {
        name                       = "Allow-Backend-SQL"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_address_prefix      = "10.1.0.32/27"
        destination_address_prefix = "10.1.0.64/27"
        source_port_range          = "*"
        destination_port_range     = "1433"
      }
    }
  }
}

# ANCHOR: PEERING
peering = {
  hub_to_spoke = {
    name                = "hub-to-spoke"
    resource_group_name = "hubspokerg"
    vnet_name           = "hub-vnet"
    remote_vnet_key     = "spoke"
  }

  spoke_to_hub = {
    name                = "spoke-to-hub"
    resource_group_name = "hubspokerg"
    vnet_name           = "spoke-vnet"
    remote_vnet_key     = "hub"
  }
}

# ANCHOR: NSG/SUBNET ASSOCIATION
# subnet_nsg_association = {

#   frontend = {
#     subnet_key = "fesubnet"
#     nsg_key    = "frontend-nsg"
#   }

#   backend = {
#     subnet_key = "besubnet"
#     nsg_key    = "backend-nsg"
#   }

#   database = {
#     subnet_key = "dbsubnet"
#     nsg_key    = "database-nsg"
#   }
# }

subnet_nsg_association = {

  frontend = {
    subnet_key = "frontendvmsubnet"
    nsg_key    = "frontend-nsg"
  }

  backend = {
    subnet_key = "backendvmsubnet"
    nsg_key    = "backend-nsg"
  }

  database = {
    subnet_key = "databasesubnet"
    nsg_key    = "database-nsg"
  }
}

# ANCHOR: KEY VAULT
key_vaults = {
  kv1 = {
    kv_name                     = "kv1"
    resource_group_name         = "hubspokerg"
    location                    = "eastus"
    sku_name                    = "standard"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
    spoke_subnet_keys           = ["frontendvmsubnet", "backendvmsubnet", "databasesubnet"]
    access_policies = [
      {
        tenant_id           = "83b21022-3e0a-4907-8856-10a1a3bcf7c9"
        object_id           = "f69f6b2e-d5e9-4a40-b525-7dabbc0f17df"
        key_permissions     = ["Get", "List"]
        secret_permissions  = ["Get"]
        storage_permissions = ["Get"]
      }
    ]
    network_acls = {
      default_action = "Deny"          # Example: "Allow" or "Deny"
      bypass         = "AzureServices" # Example: "AzureServices", "None"
    }
  }
}

# ANCHOR: KEY VAULT SECRETS
vm_passwords = {
  kv1 = "VmPass@1234!"
}

# KeyVault
#  ├── fevm1-password
#  ├── fevm2-password
#  ├── bevm1-password
#  └── bevm2-password

# admin_password = data.azurerm_key_vault_secret.vm_admin_pass[each.key].value
