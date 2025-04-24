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
}

provider "azurerm" {
  subscription_id = "4334ca2a-df73-457e-abb8-063f0a4a800c"
  features {}
}