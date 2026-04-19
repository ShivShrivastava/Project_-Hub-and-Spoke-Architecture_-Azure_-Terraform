data "azurerm_key_vault_secret" "vm_admin_pass" {
  for_each = var.key_vault_ids  # Map of Key Vault IDs

  name         = "vm-admin-password"      # Secret name in Key Vault
  # key_vault_id = var.key_vault_ids[each.key].id
  key_vault_id = each.value
}