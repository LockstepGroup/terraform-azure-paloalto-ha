output "mgmt_subnet_id" {
  value = "${data.azurerm_subnet.mgmt.id}"
}
output "outside_subnet_id" {
  value = "${data.azurerm_subnet.outside.id}"
}
output "inside_subnet_id" {
  value = "${data.azurerm_subnet.inside.id}"
}
