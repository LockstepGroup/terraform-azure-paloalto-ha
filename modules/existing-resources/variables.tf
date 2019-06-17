variable "virtual_network_resource_group_name" {
  type        = "string"
  description = "Existing Azure Virtual Network Resource Group name"
}
variable "virtual_network_name" {
  type        = "string"
  description = "Existing Azure Virtual Network name"
}
variable "mgmt_subnet_name" {
  type        = "string"
  description = "Existing management Azure Subnet name"
}
variable "outside_subnet_name" {
  type        = "string"
  description = "Existing outside Azure Subnet name"
}
variable "inside_subnet_name" {
  type        = "string"
  description = "Existing inside Azure Subnet name"
}
