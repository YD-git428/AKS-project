resource "azurerm_private_dns_zone" "blob_dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_zone_vnet_link" {
  name                  = "myVNetLink"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.blob_dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_a_record" "storage_blob_record" {
  name                = "blob"
  zone_name           = azurerm_private_dns_zone.blob_dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = var.private_ip_addresses
}