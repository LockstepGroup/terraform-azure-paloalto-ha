// resource group
resource "azurerm_resource_group" "paloalto" {
  name     = "rg_${var.paloalto_hostname}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

// availability set
resource "azurerm_availability_set" "paloalto" {
  depends_on = ["azurerm_resource_group.paloalto"]

  name                = "ab_${var.paloalto_hostname}"
  resource_group_name = "${azurerm_resource_group.paloalto.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}

// storage account
resource "azurerm_storage_account" "paloalto" {
  name                      = "stor${var.paloalto_hostname}"
  resource_group_name       = "${azurerm_resource_group.paloalto.name}"
  location                  = "${var.location}"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  enable_https_traffic_only = "true"
  tags                      = "${var.tags}"
}
