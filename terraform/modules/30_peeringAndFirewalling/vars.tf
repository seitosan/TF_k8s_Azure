variable vnet_1_name {
  description = "vnet1 to peer name"
  type        = string
}

variable vnet_1_id {
  description = "vnet1 to peer  ID"
  type        = string
}

variable vnet_1_rg {
  description = "vnet1 to peer  resource group"
  type        = string
}

variable vnet_2_name {
  description = "vnet2 to peer  name"
  type        = string
}

variable vnet_2_id {
  description = "vnet2 to peer ID"
  type        = string
}

variable vnet_2_rg {
  description = "vnet2 to peer resource group"
  type        = string
}

variable peering_name_1_to_2 {
  description = "Name of peering 1 to 2. If empty, the default value apply to it"
  type        = string
  default     = "peer1to2"
}

variable peering_name_2_to_1 {
  description = "Name of peering 2 to 1.If empty, the default value apply to it"
  type        = string
  default     = "peer2to1"
}

variable resource_group {
  description = "Resource group name"
  type        = string
}


variable pip_name {
  description = "Firewal public IP name"
  type        = string
  default     = "azure-fw-ip"
}

variable fw_name {
  description = "Firewal name"
  type        = string
}

variable subnet_id {
  description = "Subnet ID"
  type        = string
}


variable location {
  description = "Location where item will be deployed"
  type        = string
}

variable routetable_name {
  description = "RouteTable name"
  type        = string
}

variable aks_routename {
  description = "AKS route name"
  type        = string
}


variable aks_subnet {
  description = "AKS subnet ID"
  type        = string
}