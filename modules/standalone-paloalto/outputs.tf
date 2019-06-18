output "mgmt_ip" {
  value = "${azurerm_network_interface.mgmt.ip_configuration[0].private_ip_address}"
}
output "outside_pip" {
  value = "${azurerm_public_ip.outside.ip_address}"
}
output "outside_ip" {
  value = "${azurerm_network_interface.outside.ip_configuration[0].private_ip_address}"
}
output "outside_nic" {
  value = "${azurerm_network_interface.outside}"
}
output "inside_ip" {
  value = "${azurerm_network_interface.inside.ip_configuration[0].private_ip_address}"
}
