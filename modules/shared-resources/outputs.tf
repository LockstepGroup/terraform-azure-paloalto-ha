output "availability_set_id" {
  value = "${azurerm_availability_set.paloalto.id}"
}
output "storage_account" {
  value = "${azurerm_storage_account.paloalto}"
}
output "resource_group_name" {
  value = "${azurerm_resource_group.paloalto.name}"
}
