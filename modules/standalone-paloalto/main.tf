// resource group
resource "azurerm_resource_group" "paloalto" {
  name     = "${join("", list("rg_", var.hostname))}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

// storage account
resource "azurerm_storage_account" "paloalto" {
  name                      = "stor${var.hostname}"
  resource_group_name       = "${azurerm_resource_group.paloalto.name}"
  location                  = "${var.location}"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  access_tier               = "Hot"
  enable_https_traffic_only = "true"
  tags                      = "${var.tags}"
  depends_on                = ["azurerm_resource_group.paloalto"]
}

/*----------------- outside nic config ------------------ */
// outside public ip
resource "azurerm_public_ip" "outside" {
  name                = "${var.hostname}_pip_outside"
  resource_group_name = "${azurerm_resource_group.paloalto.name}"
  location            = "${var.location}"
  allocation_method   = "Static"
  tags                = "${var.tags}"
  depends_on          = ["azurerm_resource_group.paloalto"]
}

// outside nic
resource "azurerm_network_interface" "outside" {
  name                 = "${var.hostname}_outside"
  resource_group_name  = "${azurerm_resource_group.paloalto.name}"
  location             = "${var.location}"
  depends_on           = ["azurerm_public_ip.outside"]
  enable_ip_forwarding = true
  tags                 = "${var.tags}"

  ip_configuration {
    name                          = "${var.hostname}_ipc_outside"
    subnet_id                     = "${var.outside_subnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.outside_subnet.address_prefix, var.last_octet)}"
    public_ip_address_id          = "${azurerm_public_ip.outside.id}"
    primary                       = true
  }
}
/*------------------ inside nic config ------------------ */
// inside nic
resource "azurerm_network_interface" "inside" {
  name                 = "${var.hostname}_inside"
  resource_group_name  = "${azurerm_resource_group.paloalto.name}"
  location             = "${var.location}"
  enable_ip_forwarding = true
  tags                 = "${var.tags}"
  depends_on           = ["azurerm_resource_group.paloalto"]

  ip_configuration {
    name                          = "${var.hostname}_ipc_inside"
    subnet_id                     = "${var.inside_subnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.inside_subnet.address_prefix, var.last_octet)}"
    primary                       = true
  }
}

//

/*------------------ mgmt nic config ------------------ */
// mgmt nic
resource "azurerm_network_interface" "mgmt" {
  name                 = "${var.hostname}_mgmt"
  resource_group_name  = "${azurerm_resource_group.paloalto.name}"
  location             = "${var.location}"
  enable_ip_forwarding = true
  tags                 = "${var.tags}"
  depends_on           = ["azurerm_resource_group.paloalto"]

  ip_configuration {
    name                          = "${var.hostname}_ipc_mgmt"
    subnet_id                     = "${var.mgmt_subnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${cidrhost(var.mgmt_subnet.address_prefix, var.last_octet)}"
    primary                       = true
  }
}

/*-------------------- virtual machine -------------------- */
resource "azurerm_virtual_machine" "paloalto" {
  name                = "${var.hostname}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.paloalto.name}"
  vm_size             = "${var.vm_size}"

  depends_on = ["azurerm_network_interface.mgmt",
    "azurerm_network_interface.outside",
    "azurerm_network_interface.inside",
    "azurerm_storage_account.paloalto"
  ]
  plan {
    name      = "${var.market_sku}"
    publisher = "${var.market_publisher}"
    product   = "${var.market_offer}"
  }

  storage_image_reference {
    publisher = "${var.market_publisher}"
    offer     = "${var.market_offer}"
    sku       = "${var.market_sku}"
    version   = "latest"
  }

  storage_os_disk {
    name          = "${var.hostname}-osdisk"
    vhd_uri       = "${azurerm_storage_account.paloalto.primary_blob_endpoint}vhds/${var.hostname}-${var.market_offer}-${var.market_sku}.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  primary_network_interface_id = "${azurerm_network_interface.mgmt.id}"
  network_interface_ids = ["${azurerm_network_interface.mgmt.id}",
    "${azurerm_network_interface.outside.id}",
    "${azurerm_network_interface.inside.id}",
  ]

  os_profile_linux_config {
    disable_password_authentication = false
  }

  availability_set_id = "${var.availability_set_id}"
}
