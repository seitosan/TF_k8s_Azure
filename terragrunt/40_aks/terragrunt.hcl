# Create the aks cluster private
include {
  path = find_in_parent_folders()
}


terraform {
  source = "../../terraform/modules/40_aks"
}

dependency "rg" {
  config_path = "../10_rg"
  mock_outputs = {
    rg_spokename = "spoke"
    rg_region    = "westus"
    rg_hubname   = "hub"
  }
}

dependency "networks_spoke" {
  config_path = "../21_networks_spoke"
  mock_outputs = {
    vnet_id    = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC"
    subnet_ids = { aks-subnet = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC/subnets/1234567890" }
  }

}

dependency "peering" {
  config_path = "../30_peering"
  skip_outputs = true
}

inputs = {
  location                 = dependency.rg.outputs.rg_region
  kube_version             = "1.20.5"
  kube_resource_group_name = dependency.rg.outputs.rg_spokename
  nodepool_vm_size         = "Standard_D2_v2"
  kubernetes_id            = dependency.networks_spoke.outputs.subnet_ids["aks-subnet"]
  admin_rbac_kubernetes    = ["3386a976-031a-451c-b645-7dcaeff5efd4"]
  dns_private_zone         = "internals.nospof.cloud"
}
