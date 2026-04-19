# ANCHOR: RESOURCE GROUP
module "resource_group" {
  source = "../2_child_modules/1.Resource_Group"
  resource_group = var.resource_group
}

# ANCHOR: VNET
module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "../2_child_modules/2.Virtual_network"
  virtual_network = var.virtual_network
}

# ANCHOR: SUBNET
module "subnet" {
  depends_on = [ module.virtual_network ]
  source = "../2_child_modules/3.Subnet"
  subnet = var.subnet
}

# ANCHOR: PEERING
module "peering" {
  depends_on = [ module.virtual_network ]
  source = "../2_child_modules/2.1_Vnet_peering"
  peering = var.peering
  vnet_ids = module.virtual_network.vnet_ids
}

# ANCHOR: VM
module "linux_virtual_machine" {
  depends_on = [ module.subnet, module.network_interface ]
  source = "../2_child_modules/4.Virtual_Machine"

  linux_virtual_machine = var.linux_virtual_machine
  key_vault_ids = module.key_vaults.key_vault_ids
  nic_ids = module.network_interface.nic_ids
}

# ANCHOR: NIC
module "network_interface" {
  depends_on = [ module.subnet ]
  source = "../2_child_modules/5.Network_Interface"

  network_interface = var.network_interface
  subnet_ids        = module.subnet.subnet_ids
}

# ANCHOR: SQL
module "mssql_server" {
  depends_on = [ module.subnet ]
  source = "../2_child_modules/6.Sql_Database"
  mssql = var.mssql
}

# ANCHOR: PRIVATE ENDPOINT
module "private_endpoints" {
  depends_on = [  module.subnet , module.mssql_server ]
  source = "../2_child_modules/7.Private_Endpoint"
  private_endpoints = var.private_endpoints
  subnet_ids = module.subnet.subnet_ids
  sql_server_ids = module.mssql_server.sql_server_ids
}

# ANCHOR: BASTION
module "bastion" {
  source = "../2_child_modules/8.Bastion"
  bastion = var.bastion
  subnet_ids = module.subnet.subnet_ids
  public_ip_ids = module.pip.public_ip_ids
}

# ANCHOR: PUBLIC IP
module "pip" {
  depends_on = [ module.resource_group ]
  source = "../2_child_modules/9.Public_IPs"
  pip = var.pip
}

# ANCHOR: APP GATEWAY
module "appgateway" {
  depends_on = [ module.subnet, module.pip,module.network_interface ]
  source = "../2_child_modules/10.App_Gateway"
  appgateway = var.appgateway
  
  subnet_ids  = module.subnet.subnet_ids
  public_ip_ids= module.pip.public_ip_ids
  # vm_nics= module.network_interface.nic_ids
  vm_nics = var.vm_nics
  nic_private_ips= module.network_interface.nic_private_ips
}

# ANCHOR: INTERNAL LOAD BALANCER
module "ilb" {
  depends_on = [ module.subnet, module.network_interface ]
  source = "../2_child_modules/11.Internal_Load_Balancer"
  loadbalancer = var.loadbalancer
  subnet_ids  = module.subnet.subnet_ids
  backend_nics = var.backend_nics
  nic_ids      = module.network_interface.nic_ids
}

# ANCHOR: AZURE FIREWALL
module "firewall" {
  depends_on = [ module.subnet, module.pip ]
  source = "../2_child_modules/12.Azure_Firewall"
  firewall = var.firewall
  subnet_ids  = module.subnet.subnet_ids
  public_ip_ids = module.pip.public_ip_ids
}

# ANCHOR: ROUTE TABLE
module "route_tables" {
  depends_on = [  module.subnet , module.firewall ]
  source = "../2_child_modules/13.User_Defined_Route"
  route_tables = var.route_tables
  firewall_private_ips = module.firewall.firewall_private_ips
  subnet_ids  = module.subnet.subnet_ids
  subnet_route_tables = var.subnet_route_tables
}

# ANCHOR: NSG
module "nsg" {
  depends_on    = [module.subnet, module.ilb, module.appgateway, module.bastion, module.mssql_server]           # ensure LB is created first
  source        = "../2_child_modules/14.NSG"
  nsg           = var.nsg
  lb_private_ip = module.ilb.private_ip  # ✅ pass the dynamic IP   
}

# ANCHOR: NSG + Subnet Association
module "subnet_nsg_association" {
  depends_on = [ module.subnet, module.nsg ]
  source = "../2_child_modules/3.1_NSG_Subnet_Asso"
  subnet_nsg_association = var.subnet_nsg_association
  nsg_ids = module.nsg.nsg_ids
  subnet_ids  = module.subnet.subnet_ids
}

# ANCHOR: KEY VAULT
module "key_vaults" {
  # depends_on = [ module.resource_group, module.subnet ]
  source = "../2_child_modules/15.Key_Vault"

  key_vaults = var.key_vaults
  subnet_ids  = module.subnet.subnet_ids
  vm_passwords = var.vm_passwords
}








  




