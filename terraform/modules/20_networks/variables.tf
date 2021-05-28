variable subnets {
  description = "Subnets Creation of hub and spoke infra"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "resource_group_name" {
  description = "Resource group name for hub and spoke"
  type        = string
}
variable "vnet_name" {
  description = "Vnet name for hub and spoke"
  type        = string  
}
variable "address_space" {
  description = "adresse ip range used  for hub and spoke"
  type        = list(string)
}
variable "location" {
   description = "Where my subnet will be created"
   type        = string
}