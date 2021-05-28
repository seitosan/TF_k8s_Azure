# Create the hub networks typologie
include {
  path = find_in_parent_folders()
}
dependency "rg" {
  config_path = "../10_rg"
  mock_outputs = {
    rg_hubname = "hub"
    rg_region  = "westus"
  }

}
inputs = {
  resource_group_name = dependency.rg.outputs.rg_hubname
  location            = dependency.rg.outputs.rg_region
  vnet_name           = "hubvnet"
  address_space       = ["10.0.0.0/22"]
  subnets = [
    {
      name : "AzureFirewallSubnet"
      address_prefixes : ["10.0.0.0/24"]
    },
    {
      name : "jumtospoke"
      address_prefixes : ["10.0.1.0/24"]
    }
  ]
}

terraform {
  source = "../../terraform/modules/20_networks"
}
