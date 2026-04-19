output "key_vault_ids" {
  description = "Map of Key Vault names to their IDs"
  value = {
    for kv_name, kv in azurerm_key_vault.kv : kv_name => kv.id
  }
}