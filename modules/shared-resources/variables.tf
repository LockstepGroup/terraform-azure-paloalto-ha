variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "paloalto_hostname" {
  type        = string
  description = "Palo Alto firewall Hostname"
}
variable "tags" {
  description = "Tags to apply to all new resources"
}
