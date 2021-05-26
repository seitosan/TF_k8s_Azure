remote_state {
    backend ="azurerm"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "Infra"
        storage_account_name = "alsidetechnicaltest"
        container_name = "state"
    }   
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
    terraform {
        required_providers {
            azurerm = {
                source = "hashicorp/azurerm"
                version = "2.60.0"
            }
        }
    }
    provider "azurerm" {
        features {
            
        }
    }
  EOF
}
