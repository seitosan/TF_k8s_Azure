variable "location" {
  description = "The resource group location"
  default     = "West Europe"
}

variable "kube_version" {
  description = "AKS Kubernetes version"
  default =  "1.20.5"
}

variable "kube_resource_group_name" {
  description = "The resource group name to be created"
  default     = "nopublicipaks"
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_D2_v2"
}

variable "network_docker_bridge_cidr" {
  description = "CNI Docker bridge cidr"
  default     = "172.17.0.1/16"
}

variable "network_dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.2.0.10"
}

variable "network_service_cidr" {
  description = "CNI service cidr"
  default     = "10.2.0.0/24"
}
variable "kubernetes_id" {
  description ="id of the network hosted Kubernetes"
  default="/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC/subnets/1234567890"
  type = string
}

variable "admin_rbac_kubernetes" {
  description = "uuid of rbac user"
  default=[""]
  type = list(string)
}

variable "dns_private_zone" {
  description = "specify a new dns private zone"
  default = "internals.nospof.cloud"
  type= string
}