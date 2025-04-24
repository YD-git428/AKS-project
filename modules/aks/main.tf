resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                = "aks-cluster"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks"
  kubernetes_version  = "1.30.0"
  workload_identity_enabled = true
  oidc_issuer_enabled = true
  api_server_access_profile {
    authorized_ip_ranges = ["188.30.140.0/24"]
  }

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

   network_profile {
    network_plugin    = "azure"  
    network_policy    = "azure" 
    service_cidr      = "10.0.0.0/16" 
    dns_service_ip    = "10.0.0.10"
  }

 identity {
   type = "UserAssigned" 
   identity_ids = [azurerm_user_assigned_identity.my_identity.id]
 }

  role_based_access_control_enabled = true
}

resource "azurerm_user_assigned_identity" "my_identity" {
  name                = "my-identity"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}
