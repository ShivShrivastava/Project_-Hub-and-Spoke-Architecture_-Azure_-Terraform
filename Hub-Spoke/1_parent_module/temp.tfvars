# RESOURCE GROUP
resource_group = {
  rg1 = {
    rg_name     = "hubspokerg"
    rg_location = "eastus"
  }
}

# VIRTUAL NETWORK
virtual_network = {
  hub = {
    vnet_name           = "hubvnet"
    vnet_location       = "eastus"
    resource_group_name = "hubspokerg"
    address_space       = ["10.0.0.0/24"]
  }

  spoke = {
    vnet_name           = "spokevnet"
    vnet_location       = "eastus"
    resource_group_name = "hubspokerg"
    address_space       = ["10.1.0.0/24"]
  }
}

# SUBNETS
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

# NETWORK INTERFACE
network_interface = {
  fevm1 = {
    vm_name             = "fevm1"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    subnet_name         = "fesubnet"
    private_ip_address_allocation = "Dynamic"
  }
}

# LINUX VM
linux_virtual_machine = {
  fevm1 = {
    vm_name             = "fevm1"
    resource_group_name = "hubspokerg"
    vm_location         = "eastus"
    size                = "Standard_B2ats_v2"
    admin_username      = "adminuser"
    admin_password      = "DummyPass@123"

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
}

# PUBLIC IPS
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

# BASTION
bastion = {
  bastion = {
    bastion_name        = "bastion"
    bastion_location    = "eastus"
    resource_group_name = "hubspokerg"
    subnet_name         = "bastion"
    public_ip_name      = "bastion-pip"
  }
}

# MSSQL
mssql = {
  sqlserver1 = {
    server_name                  = "dbsqlserver"
    resource_group_name          = "hubspokerg"
    location                     = "eastus"
    version                      = "12.0"
    administrator_login          = "sqladmin"
    administrator_login_password = "DummySQL@123"

    database_name = "appdb"
    collation     = "SQL_Latin1_General_CP1_CI_AS"
    license_type  = "LicenseIncluded"
    max_size_gb   = 2
    sku_name      = "S0"
    enclave_type  = "VBS"
  }
}

# FIREWALL
firewall = {
  hubfw = {
    fw_name        = "hubvnet-fw"
    resource_group = "hubspokerg"
    location       = "eastus"
    subnet_name    = "firewall"
    public_ip_name = "firewall-pip"
    sku_name       = "AZFW_VNet"
    sku_tier       = "Standard"
  }
}

# APP GATEWAY
appgateway = {
  appgw-east = {
    ag_name             = "hubappgw"
    ag_location         = "eastus"
    resource_group_name = "hubspokerg"

    sku_name     = "Standard_v2"
    sku_tier     = "Standard_v2"
    sku_capacity = 2

    subnet_name    = "appgateway"
    public_ip_name = "appgateway-pip"

    frontend_port = 80

    backend_pool_name         = "backend-pool-east"
    http_setting_name         = "http-setting-east"
    listener_name             = "listener-east"
    request_routing_rule_name = "rule-east"
  }
}

# VNET PEERING
peering = {
  hub-to-spoke = {
    name                = "hub-to-spoke-peering"
    resource_group_name = "hubspokerg"
    vnet_name           = "hubvnet"
    remote_vnet_key     = "spoke"
  }

  spoke-to-hub = {
    name                = "spoke-to-hub-peering"
    resource_group_name = "hubspokerg"
    vnet_name           = "spokevnet"
    remote_vnet_key     = "hub"
  }
}

# PRIVATE ENDPOINT
private_endpoints = {
  pe1 = {
    pe_name                       = "pe-database"
    pe_location                   = "eastus"
    resource_group_name           = "hubspokerg"
    subnet_name                   = "pe-subnet"
    private_connection_name       = "sqlserver1"
    private_connection_resource_id = "sqlserver1"
  }
}

# KEY VAULT
key_vaults = {
  kv1 = {
    kv_name                     = "kv1"
    resource_group_name         = "hubspokerg"
    location                    = "eastus"
    sku_name                    = "standard"
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    enabled_for_disk_encryption = true
    spoke_subnet_keys           = ["fesubnet"]
    access_policies             = []   # ya add policies if needed
    network_acls = {
      default_action = "Allow"
      bypass         = "AzureServices"
    }
  }
}

vm_passwords = {
  kv1 = "VmPass@1234!"
}

# IDS (DUMMY FOR MODULE LINKS)

vnet_ids = {
  hub   = "dummy-hub-vnet-id"
  spoke = "dummy-spoke-vnet-id"
}

subnet_ids = {
  bastion    = "dummy-bastion-subnet-id"
  firewall   = "dummy-firewall-subnet-id"
  appgateway = "dummy-appgateway-subnet-id"
  fesubnet   = "dummy-fe-subnet-id"
  besubnet   = "dummy-be-subnet-id"
  dbsubnet   = "dummy-db-subnet-id"
  pe-subnet  = "dummy-pe-subnet-id"
}

public_ip_ids = {
  bastion-pip    = "dummy-bastion-pip-id"
  appgateway-pip = "dummy-ag-pip-id"
  firewall-pip   = "dummy-fw-pip-id"
}

sql_server_ids = {
  sqlserver1 = "dummy-sql-id"
}

# LOAD BALANCER
loadbalancer = {
  ilb1 = {
    lb_name               = "internal-ilb"
    location              = "eastus"
    resource_group_name   = "hubspokerg"
    subnet_name           = "besubnet"
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

# BACKEND NICs
backend_nics = {
  bevm1 = {
    nic = "bevm1-nic"
  }

  bevm2 = {
    nic = "bevm2-nic"
  }
}

# NIC IDS
nic_ids = {
  fevm1-nic = "dummy-fevm1-nic-id"
  fevm2-nic = "dummy-fevm2-nic-id"
  bevm1-nic = "dummy-bevm1-nic-id"
  bevm2-nic = "dummy-bevm2-nic-id"
}

# NIC PRIVATE IPS
nic_private_ips = {
  fevm1-nic = "10.1.0.4"
  fevm2-nic = "10.1.0.5"
  bevm1-nic = "10.1.0.36"
  bevm2-nic = "10.1.0.37"
}

# APPLICATION GATEWAY NIC MAP
vm_nics = {
  appgw-east = ["fevm1-nic","fevm2-nic"]
}

# FIREWALL PRIVATE IP
firewall_private_ips = {
  hubfw = "10.0.0.4"
}

# LOAD BALANCER PRIVATE IP
lb_private_ip = "10.1.0.38"

# NSG
nsg = {
  frontend-nsg = {
    nsg_name       = "frontend-nsg"
    location       = "eastus"
    resource_group = "hubspokerg"
    security_rules = {}
  }
}

# NSG IDS
nsg_ids = {
  frontend-nsg = "dummy-frontend-nsg-id"
}

# SUBNET NSG ASSOCIATION
subnet_nsg_association = {
  frontend = {
    subnet_key = "fesubnet"
    nsg_key    = "frontend-nsg"
  }
}

# ROUTE TABLES
route_tables = {
  hubfw-rt = {
    rt_name             = "hub-fw-rt"
    resource_group_name = "hubspokerg"
    location            = "eastus"
    subnet_names        = ["fesubnet"]
    next_hop_ip         = "hubfw"
  }
}

# KEY VAULT IDS
key_vault_ids = {
  kv1 = "dummy-kv-id"
}