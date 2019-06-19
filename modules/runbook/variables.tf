variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group name"
}
variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "automation_account_name" {
  type        = string
  description = "Palo Alto firewall Hostname"
}
// service principal
variable "pa_sp_display_name" {
  type        = string
  description = "Display Name for Service Principal to move IP Configurations"
}
variable "pa_sp_client_id" {
  type        = string
  description = "Client ID for Service Principal to move IP Configurations"
}
variable "pa_sp_client_secret" {
  type        = string
  description = "Client Secret for Service Principal to move IP Configurations"
}
// variables
variable "primary_pa_mgmt_ipaddress" {
  type        = string
  description = "IP Address or Hostname of Management interface for Primary Palo Alto"
}
variable "secondary_pa_mgmt_ipaddress" {
  type        = string
  description = "IP Address or Hostname of Management interface for Secondary Palo Alto"
}
variable "pa_admin_username" {
  type        = string
  description = "Palo Alto admin username"
}
variable "pa_admin_password" {
  type        = string
  description = "Palo Alto admin password"
}
