// Azure login
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

// create shared resources
module "shared_resources" {
  source = "./modules/shared-resources"

  paloalto_hostname = "${var.primary_pa_hostname}"
  location          = "${var.location}"
  tags              = "${var.tags}"
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

  location            = "${var.location}"
  resource_group_name = "${module.shared_resources.resource_group_name}"
  storage_account     = "${module.shared_resources.storage_account}"
  hostname            = "${var.primary_pa_hostname}"
  tags                = "${var.tags}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  outside_subnet      = "${module.existing_resources.outside_subnet}"
  inside_subnet       = "${module.existing_resources.inside_subnet}"
  mgmt_subnet         = "${module.existing_resources.mgmt_subnet}"
  last_octet          = "${var.primary_pa_last_octet}"
  availability_set_id = "${module.shared_resources.availability_set_id}"
}

// secondary pa
module "secondary_pa" {
  source = "./modules/standalone-paloalto"

  location            = "${var.location}"
  resource_group_name = "${module.shared_resources.resource_group_name}"
  storage_account     = "${module.shared_resources.storage_account}"
  hostname            = "${var.secondary_pa_hostname}"
  tags                = "${var.tags}"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  outside_subnet      = "${module.existing_resources.outside_subnet}"
  inside_subnet       = "${module.existing_resources.inside_subnet}"
  mgmt_subnet         = "${module.existing_resources.mgmt_subnet}"
  last_octet          = "${var.primary_pa_last_octet + 1}"
  availability_set_id = "${module.shared_resources.availability_set_id}"
}
