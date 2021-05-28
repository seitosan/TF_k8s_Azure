# Create the peerings
include {
  path = find_in_parent_folders()
}
dependency "networks_hub" {
  config_path = "../20_networks_hub"
  mock_outputs = {
    vnet_id = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC"

    subnet_ids = { AzureFirewallSubnet = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC/subnets/1234567890", jumtospoke = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC/subnets/1234567890" }
  }

}
dependency "networks_spoke" {
  config_path = "../21_networks_spoke"
  mock_outputs = {
    vnet_id    = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC"
    subnet_ids = { aks-subnet = "/azerty/resource/subscriptions/234-23456-34567-34567/resourceGroups/TESTING/providers/Microsoft.Network/virtualNetworks/POC/subnets/1234567890" }
  }

}

dependency "rg" {
  config_path = "../10_rg"
  mock_outputs = {
    rg_spokename = "spoke"
    rg_region    = "westus"
    rg_hubname   = "hub"
  }
}

inputs = {
  vnet_1_name         = "hubVnet"
  vnet_1_id           = dependency.networks_hub.outputs.vnet_id
  vnet_1_rg           = dependency.rg.outputs.rg_hubname
  vnet_2_name         = "spokeVnet"
  vnet_2_id           = dependency.networks_spoke.outputs.vnet_id
  vnet_2_rg           = dependency.rg.outputs.rg_spokename
  peering_name_1_to_2 = "HubToSpoke"
  peering_name_2_to_1 = "SpokeToHub"
  resource_group      = dependency.rg.outputs.rg_hubname
  location            = dependency.rg.outputs.rg_region
  pip_name            = "pubIpFirewall"
  fw_name             = "aksfw"
  subnet_id           = dependency.networks_hub.outputs.subnet_ids["AzureFirewallSubnet"]
  routetable_name     = "katefwrouting"
  aks_routename       = "katefwroutingrules"
  aks_subnet          = dependency.networks_spoke.outputs.subnet_ids["aks-subnet"]
}

terraform {
  source = "../../terraform/modules/30_peeringAndFirewalling"
}
