include {
  path = find_in_parent_folders()
}

inputs = {
  location                 = "westus"
  kube_resource_group_name = "privateaks"
  vnet_resource_group_name = "privateaksvnet"
}

terraform {
  source = "../../terraform/modules/10_rg"
}
