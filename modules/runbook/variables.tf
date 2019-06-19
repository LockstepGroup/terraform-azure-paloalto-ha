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
