resource "azurerm_automation_account" "ha_switcher" {
  name                = "${var.automation_account_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  sku {
    name = "Basic"
  }
}

data "local_file" "ha_switcher" {
  filename = "${path.module}/Invoke-PaAzureFailover.ps1"
}

resource "azurerm_automation_runbook" "ha_switcher" {
  name                = "Invoke-PaAzureFailover"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  account_name        = "${azurerm_automation_account.ha_switcher.name}"
  log_verbose         = "true"
  log_progress        = "true"
  description         = "Moves secondary IP Configurations between Palo Alto firewalls in the event of failover."
  runbook_type        = "PowerShell"

  publish_content_link {
    uri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
  }

  content = "${data.local_file.ha_switcher.content}"
}

resource "azurerm_automation_credential" "service_principal" {
  name                = "${var.pa_sp_display_name}"
  resource_group_name = "${var.resource_group_name}"
  account_name        = "${azurerm_automation_account.ha_switcher.name}"
  username            = "${var.pa_sp_client_id}"
  password            = "${var.pa_sp_client_secret}"
  description         = "Credential used to move IP Configurations between Palo Altos"
}

resource "azurerm_automation_credential" "pa_admin" {
  name                = "Palo Alto firewall admin account"
  resource_group_name = "${var.resource_group_name}"
  account_name        = "${azurerm_automation_account.ha_switcher.name}"
  username            = "${var.pa_admin_username}"
  password            = "${var.pa_admin_password}"
  description         = "Credential used to move IP Configurations between Palo Altos"
}

// primary pa variables
resource "azurerm_automation_variable_string" "PrimaryFirewallHostname" {
  name                    = "PrimaryFirewallHostname"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.ha_switcher.name}"
  value                   = "${var.primary_pa_mgmt_ipaddress}"
}

resource "azurerm_automation_variable_string" "PrimaryFirewallResourceGroupName" {
  name                    = "PrimaryFirewallResourceGroupName"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.ha_switcher.name}"
  value                   = "${var.resource_group_name}"
}

// secondary pa variables
resource "azurerm_automation_variable_string" "SecondaryFirewallHostname" {
  name                    = "SecondaryFirewallHostname"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.ha_switcher.name}"
  value                   = "${var.secondary_pa_mgmt_ipaddress}"
}

resource "azurerm_automation_variable_string" "SecondaryFirewallResourceGroupName" {
  name                    = "SecondaryFirewallResourceGroupName"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.ha_switcher.name}"
  value                   = "${var.resource_group_name}"
}
