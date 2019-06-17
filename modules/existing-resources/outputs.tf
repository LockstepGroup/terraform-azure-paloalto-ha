output "mgmt_subnet" {
  value = "${data.azurerm_subnet.mgmt}"
}
output "outside_subnet" {
  value = "${data.azurerm_subnet.outside}"
}
output "inside_subnet" {
  value = "${data.azurerm_subnet.inside}"
}
