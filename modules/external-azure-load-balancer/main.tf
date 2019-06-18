resource "azurerm_lb" "paloalto" {
  name                = "alb_${var.load_balancer_name}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  tags                = "${var.tags}"

  frontend_ip_configuration {
    name                          = "${var.load_balancer_name}_ipc_frontend"
    subnet_id                     = "${var.frontend_subnet.id}"
    private_ip_address            = "${cidrhost(var.frontend_subnet.address_prefix, var.last_octet)}"
    private_ip_address_allocation = "Static"
  }
}

// backend address pool
resource "azurerm_lb_backend_address_pool" "paloalto" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.paloalto.id}"
  name                = "paloalto_healtcheck"
}

// associate primary paloalto to backend pool
resource "azurerm_network_interface_backend_address_pool_association" "primary" {
  network_interface_id    = "${var.primary_pa_outside_nic.id}"
  ip_configuration_name   = "${var.primary_pa_outside_nic.ip_configuration[0].name}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.paloalto.id}"
}

// associate secondary paloalto to backend pool
resource "azurerm_network_interface_backend_address_pool_association" "secondary" {
  network_interface_id    = "${var.secondary_pa_outside_nic.id}"
  ip_configuration_name   = "${var.secondary_pa_outside_nic.ip_configuration[0].name}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.paloalto.id}"
}

// health probe
resource "azurerm_lb_probe" "tcp_443" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.paloalto.id}"
  name                = "tcp_443"
  port                = 443
  protocol            = "tcp"
  interval_in_seconds = 5
}
