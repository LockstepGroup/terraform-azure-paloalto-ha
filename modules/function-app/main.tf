resource "azurerm_app_service_plan" "ha" {
  name                = "${var.function_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "ha" {
  name                      = "${var.function_name}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  app_service_plan_id       = "${azurerm_app_service_plan.ha.id}"
  storage_connection_string = "${var.azurerm_storage_account.primary_connection_string}"
}
