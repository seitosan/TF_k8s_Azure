include {
  path = find_in_parent_folders()
}

inputs = {
  location = "westus"
  resource_group_name = "alsideaks"
}

terraform {
  source = "../../terraform/modules/10_rg"
}
