module "aks-cluster" {
  source = "../modules/aks"
  resource_group_location = var.location
  resource_group_name = var.resource_group_name

}


