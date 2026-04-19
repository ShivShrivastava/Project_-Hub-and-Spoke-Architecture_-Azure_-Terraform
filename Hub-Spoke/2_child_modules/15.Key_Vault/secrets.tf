resource "azurerm_key_vault_secret" "vm_secret" {
  for_each = var.key_vaults

  name         = "vm-admin-password"
  value        = var.vm_passwords[each.key]
  key_vault_id = azurerm_key_vault.kv[each.key].id
}