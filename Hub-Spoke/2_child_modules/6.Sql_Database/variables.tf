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