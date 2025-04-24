terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">=2.6"
    }
  }

backend "azurerm" {
      resource_group_name  = "coderco-azureproj"
      storage_account_name = "aksstorageacc1653"
      container_name       = "terraformstate-backend"
      key                  = "terraform.tfstate"

  }
}

provider "azurerm" {
  subscription_id = "4334ca2a-df73-457e-abb8-063f0a4a800c"
  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.aks-cluster.kube_config.0.host
    client_certificate     = base64decode(module.aks-cluster.kube_config.0.client_certificate)
    client_key             = base64decode(module.aks-cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(module.aks-cluster.kube_config.0.cluster_ca_certificate)

  }
}