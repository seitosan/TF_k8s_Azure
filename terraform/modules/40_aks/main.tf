resource "azurerm_kubernetes_cluster" "privateaks" {
  name                    = "private-aks"
  location                = var.location
  kubernetes_version      = var.kube_version
  resource_group_name     = var.kube_resource_group_name
  dns_prefix              = "private-aks"
  private_cluster_enabled = true
  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = var.nodepool_vm_size
    vnet_subnet_id = var.kubernetes_id
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    http_application_routing {
      enabled = false
    }

    kube_dashboard {
      enabled = false
    }
    azure_policy {
      # if true : updating Subnet: (Name "aks-subnet" / Virtual Network Name "spokevnet" / Resource Group "alsideaks"): network.SubnetsClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="PrivateEndpointNetworkPoliciesCannotBeEnabledOnPrivateEndpointSubnet" Message="Private endpoint network policies cannot be enabled on private endpoint subnet /subscriptions/#####/resourceGroups/alsideaks/providers/Microsoft.Network/virtualNetworks/spokevnet/subnets/aks-subnet." Details=[]
      enabled = false
    }

  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      admin_group_object_ids = var.admin_rbac_kubernetes
    }
  }


  network_profile {
    docker_bridge_cidr = var.network_docker_bridge_cidr
    dns_service_ip     = var.network_dns_service_ip
    network_plugin     = "azure"
    network_policy     = "calico"
    outbound_type      = "loadBalancer"
    service_cidr       = var.network_service_cidr
  }
}
# Retrieve the sub id
data "azurerm_subscription" "current" {}

# https://github.com/Azure/AKS/issues/1557
#resource "azurerm_role_assignment" "vmcontributor" {
#  role_definition_name = "Contributor"
#  scope                = data.azurerm_subscription.current.id
#  principal_id         = azurerm_kubernetes_cluster.privateaks.identity[0].principal_id
#}

# create Windows Nodepool support

resource "azurerm_kubernetes_cluster_node_pool" "windows" {
  name                  = "win"
  enable_node_public_ip = false
  os_type               = "Windows"
  os_disk_size_gb = 100
  os_disk_type = "Managed"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.privateaks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  node_labels  ={workload-type="windows"}
  tags = {
    Environment = "Production"
  }
}

# create Linux Nodepool support

resource "azurerm_kubernetes_cluster_node_pool" "linux" {
  name                  = "linux"
  enable_node_public_ip = false
  os_type               = "Linux"
  os_disk_size_gb       = 100
  os_disk_type          = "Managed"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.privateaks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  node_labels  ={workload-type="linux"}
  tags = {
    Environment = "Production"
  }
}


resource "azurerm_storage_account" "storage" {
  name                     = "auditaksalsidtt2"
  resource_group_name      = azurerm_kubernetes_cluster.privateaks.resource_group_name
  location                 = azurerm_kubernetes_cluster.privateaks.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "audit" {
  name               = "aks-audit"
  target_resource_id = azurerm_kubernetes_cluster.privateaks.id
  storage_account_id = azurerm_storage_account.storage.id

  log {
    category = "kube-audit-admin"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }

  log {
    category = "kube-audit"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "kube-apiserver"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "kube-controller-manager"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "kube-scheduler"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "cluster-autoscaler"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  log {
    category = "guard"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 7
    }
  }
}

# Private DNS Zone for deploy Ingress hostname
resource "azurerm_private_dns_zone" "privatedns" {
  name                = var.dns_private_zone
  resource_group_name = var.kube_resource_group_name
}