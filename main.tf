// Azure login
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

// gather existing resource info (virtual network, subnets)
module "existing_resources" {
  source = "./modules/existing-resources"

  virtual_network_resource_group_name = "${var.virtual_network_resource_group_name}"
  virtual_network_name                = "${var.virtual_network_name}"
  mgmt_subnet_name                    = "${var.mgmt_subnet_name}"
  outside_subnet_name                 = "${var.outside_subnet_name}"
  inside_subnet_name                  = "${var.inside_subnet_name}"
}

// primary pa
module "primary_pa" {
  source = "./modules/standalone-paloalto"

  location       = "${var.location}"
  hostname       = "${var.primary_pa_hostname}"
  tags           = "${var.tags}"
  admin_username = "${var.admin_username}"
  admin_password = "${var.admin_password}"
  outside_subnet = "${module.existing_resources.outside_subnet}"
  inside_subnet  = "${module.existing_resources.inside_subnet}"
  mgmt_subnet    = "${module.existing_resources.mgmt_subnet}"
  last_octet     = "${var.primary_pa_last_octet}"
}
