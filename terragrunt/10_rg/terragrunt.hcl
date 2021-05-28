include {
  path = find_in_parent_folders()
}

inputs = {
  location                 = "westus"
  kube_resource_group_name = "alsideaks"
  vnet_resource_group_name = "alsideaksvnet"
}

terraform {
  source = "../../terraform/modules/10_rg"
}
