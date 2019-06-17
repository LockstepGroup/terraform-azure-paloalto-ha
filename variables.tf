/* ------------------------------------ main.tf ------------------------------------ */
// azure login info
variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID, see https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure"
}
variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID, see https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure"
}
variable "client_id" {
  type        = string
  description = "Azure Service Principal App ID, see https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure"
}
variable "client_secret" {
  type        = string
  description = "Azure Service Principal Password/Secret, see https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure"
}
/* ------------------------------------ modules/existing-resources ------------------------------------ */
// existing network resources
variable "virtual_network_resource_group_name" {
  type        = string
  description = "Existing Azure Virtual Network Resource Group name"
}
variable "virtual_network_name" {
  type        = string
  description = "Existing Azure Virtual Network name"
}
variable "mgmt_subnet_name" {
  type        = string
  description = "Existing management Azure Subnet name"
}
variable "outside_subnet_name" {
  type        = string
  description = "Existing outside Azure Subnet name"
}
variable "inside_subnet_name" {
  type        = string
  description = "Existing inside Azure Subnet name"
}
/* ------------------------------------ shared info ------------------------------------ */
variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "tags" {
  description = "Tags to apply to all new resources"
}
/* ------------------------------------ modules/standalone-paloalto ------------------------------------ */
variable "primary_pa_hostname" {
  type        = string
  description = "Primary Palo Alto firewall Hostname"
}
variable "secondary_pa_hostname" {
  type        = string
  description = "Primary Palo Alto firewall Hostname"
}
// local credentials for new firewalls
variable "admin_username" {
  type        = string
  description = "Local admin account name for Palo Alto firewalls"
}
variable "admin_password" {
  type        = string
  description = "Local admin password for Palo Alto firewalls"
}
// last octet for ip objects
variable "primary_pa_last_octet" {
  type        = number
  description = "Last octet to use for each Network Interface"
}
