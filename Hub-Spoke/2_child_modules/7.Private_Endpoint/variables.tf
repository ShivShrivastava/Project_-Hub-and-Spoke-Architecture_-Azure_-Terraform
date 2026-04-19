variable "private_endpoints" {
  type = map(object({
    pe_name                       = string
    pe_location                   = string
    resource_group_name        = string
    subnet_name                = string
    private_connection_name    = string
    private_connection_resource_id = string
  }))
}

variable "subnet_ids" {
  type = map(string)
}

variable "sql_server_ids" {
  type = map(string)
}