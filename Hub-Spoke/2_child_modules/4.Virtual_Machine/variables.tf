variable "linux_virtual_machine" {
  type = map(object({
    vm_name             = string
    resource_group_name = string
    vm_location         = string
    size                = string
    admin_username      = string
    admin_password      = string

    # OS Disk settings
    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    # Source image settings
    source_image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

# variable "key_vaults" {}

variable "key_vault_ids" {}

variable "nic_ids" {}