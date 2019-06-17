// resource group
resource "azurerm_resource_group" "paloalto_shared" {
  name     = "rg_${var.paloalto_hostname}-shared"
  location = "${var.location}"
  tags     = "${var.tags}"
}

// availability set
resource "azurerm_availability_set" "paloalto_shared" {
  depends_on = ["azurerm_resource_group.paloalto_shared"]

  name                = "ab_${var.paloalto_hostname}"
  resource_group_name = "${azurerm_resource_group.paloalto_shared.name}"
  location            = "${var.location}"
  tags                = "${var.tags}"
}
