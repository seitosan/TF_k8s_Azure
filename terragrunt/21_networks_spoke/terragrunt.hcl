# Create the spoke networks typologie
include {
  path = find_in_parent_folders()
}

inputs = {
  resource_group_name = dependency.rg.outputs.rg_spokename
  location            = dependency.rg.outputs.rg_region
  vnet_name           = "spokevnet"
  address_space       = ["10.0.4.0/22"]
  subnets = [
    {
      name : "aks-subnet"
      address_prefixes : ["10.0.5.0/24"]
    }
  ]
}

terraform {
  source = "../../terraform/modules/20_networks"
}
dependency "rg" {
  config_path = "../10_rg"
  mock_outputs = {
    rg_spokename = "spoke"
    rg_region    = "westus"
  }
}