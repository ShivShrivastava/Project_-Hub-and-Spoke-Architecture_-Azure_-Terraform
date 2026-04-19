# data "azuread_client_config" "current" {}

# resource "azuread_application" "spapp" {
#   display_name = "sp_keyvault"
#   owners       = [data.azuread_client_config.current.object_id]
# }

# resource "azuread_service_principal" "sp" {
#   client_id                    = azuread_application.spapp.client_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
# }