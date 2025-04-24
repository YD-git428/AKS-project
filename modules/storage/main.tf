resource "azurerm_storage_account" "az_storage_account" {
  name                = "aksstorageacc1653"
  resource_group_name = var.resource_group_name

  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  network_rules {
    default_action             = "Deny"
    bypass                     = [ "AzureServices" ] #for monitoring service access
    virtual_network_subnet_ids = [var.priv_subnet_1, var.priv_subnet_2, var.priv_subnet3]
    ip_rules = [ "188.30.140.0/24" ]
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "terraformstate-backend"
  storage_account_id    = azurerm_storage_account.az_storage_account.id
  container_access_type = "private"
}