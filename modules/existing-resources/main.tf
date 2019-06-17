data "azurerm_subnet" "mgmt" {
  name                 = "${var.mgmt_subnet_name}"
  resource_group_name  = "${var.virtual_network_resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
}
data "azurerm_subnet" "outside" {
  name                 = "${var.outside_subnet_name}"
  resource_group_name  = "${var.virtual_network_resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
}
data "azurerm_subnet" "inside" {
  name                 = "${var.inside_subnet_name}"
  resource_group_name  = "${var.virtual_network_resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
}

