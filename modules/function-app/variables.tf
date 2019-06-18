variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group name"
}
variable "storage_account" {
  description = "Azure Storage Account object"
}
variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "function_name" {
  type        = string
  description = "Palo Alto firewall Hostname"
}
