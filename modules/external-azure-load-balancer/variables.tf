variable "resource_group_name" {
  type        = string
  description = "Azure Resource Group name"
}
variable "location" {
  type        = string
  description = "Desired Azure Location"
  default     = "eastus2"
}
variable "load_balancer_name" {
  type        = string
  description = "Azure Load Balancer name"
}
variable "tags" {
  description = "Tags to apply to all new resources"
}
variable "frontend_subnet" {
  description = "Azure Subnet to use for ALB frontend"
}
variable "last_octet" {
  type        = number
  description = "Last octet to use for each Network Interface"
}
variable "primary_pa_outside_nic" {
  description = "Primary Palo Alto outside NIC"
}
variable "secondary_pa_outside_nic" {
  description = "Secondary Palo Alto outside NIC"
}
