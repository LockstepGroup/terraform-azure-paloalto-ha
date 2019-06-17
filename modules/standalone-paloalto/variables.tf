variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "hostname" {
  type        = string
  description = "Palo Alto firewall Hostname"
}
variable "tags" {
  description = "Tags to apply to all new resources"
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
// subnets
variable "outside_subnet" {
  description = "Azure Subnet to use for outside Network Interface"
}
variable "inside_subnet" {
  description = "Azure Subnet to use for inside Network Interface"
}
variable "mgmt_subnet" {
  description = "Azure Subnet to use for management Network Interface"
}
// last octet for ip objects
variable "last_octet" {
  type        = number
  description = "Last octet to use for each Network Interface"
}
// vm selection
variable "vm_size" {
  type        = "string"
  description = "Virtual machine size for Palo Alto firewalls"
  default     = "Standard_D3_v2"
}
variable "market_publisher" {
  type        = "string"
  description = "Marketplace Publisher for Palo Alto firewalls"
  default     = "paloaltonetworks"
}
variable "market_offer" {
  type        = "string"
  description = "Marketplace Offer for Palo Alto firewalls"
  default     = "vmseries1"
}
variable "market_sku" {
  type        = "string"
  description = "Marketplace SKU for Palo Alto firewalls"
  default     = "byol"
}
variable "market_version" {
  type        = "string"
  description = "Marketplace version for Palo Alto firewalls"
  default     = "latest"
}
// availability_set_id
variable "availability_set_id" {
  type        = "string"
  description = "Availability set id for NetScaler"
}
