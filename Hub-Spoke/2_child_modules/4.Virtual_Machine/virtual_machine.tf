resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.linux_virtual_machine

  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.vm_location
  size                = each.value.size
  admin_username      = each.value.admin_username
  # admin_password      = data.azurerm_key_vault_secret.vm_admin_pass[each.key].value
  admin_password = data.azurerm_key_vault_secret.vm_admin_pass["kv1"].value

  network_interface_ids = [
    var.nic_ids[each.key]
  ]

  # Only password authentication
  disable_password_authentication = false

  # OS disk from variable
  os_disk {
    caching              = each.value.os_disk.caching
    storage_account_type = each.value.os_disk.storage_account_type
  }

  # Source image reference from variable
  source_image_reference {
    publisher = each.value.source_image.publisher
    offer     = each.value.source_image.offer
    sku       = each.value.source_image.sku
    version   = each.value.source_image.version
  }
}