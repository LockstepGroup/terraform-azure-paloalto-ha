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
