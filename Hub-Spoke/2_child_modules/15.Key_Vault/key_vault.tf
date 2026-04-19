provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy     = true
      recover_soft_deleted_key_vaults  = true
    }
  }
}

data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "kv" {
  for_each = var.key_vaults

  name                        = each.value.kv_name
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = each.value.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = each.value.soft_delete_retention_days
  purge_protection_enabled    = each.value.purge_protection_enabled

  sku_name = each.value.sku_name

  network_acls {
    default_action             = each.value.network_acls.default_action
    bypass                     = each.value.network_acls.bypass
    virtual_network_subnet_ids = [for k in each.value.spoke_subnet_keys : var.subnet_ids[k]]
  }

  dynamic "access_policy" {
    for_each = each.value.access_policies
    content {
      tenant_id           = access_policy.value.tenant_id
      object_id           = access_policy.value.object_id
      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }
}