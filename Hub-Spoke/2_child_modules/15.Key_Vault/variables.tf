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

variable "subnet_ids" {
  type = map(string)
}

variable "vm_passwords" {
  description = "Map of VM admin passwords per Key Vault"
  type        = map(string)
  sensitive   = true
}