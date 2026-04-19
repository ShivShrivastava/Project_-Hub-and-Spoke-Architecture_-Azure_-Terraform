# output "subnet_ids" {
#   value = {
#     for k, v in azurerm_subnet.subnet :
#     k => v.id
#   }
# }


output "subnet_ids" {
  value = { for s, sub in azurerm_subnet.subnet : sub.name => sub.id }
}