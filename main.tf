// Azure login
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

// gather existing resource info (virtual network, subnets)
module "existing-resources" {
  source = "./modules/existing-resources"

  virtual_network_resource_group_name = "${var.virtual_network_resource_group_name}"
  virtual_network_name                = "${var.virtual_network_name}"
  mgmt_subnet_name                    = "${var.mgmt_subnet_name}"
  outside_subnet_name                 = "${var.outside_subnet_name}"
  inside_subnet_name                  = "${var.inside_subnet_name}"
}
