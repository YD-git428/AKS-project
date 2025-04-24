output "resource_group_name" {
  value = azurerm_resource_group.coderco.name
}

output "resource_group_location" {
  value = azurerm_resource_group.coderco.location
}

output "vnet_id" {
  value = azurerm_virtual_network.coderco_vnet.id
}

output "subnet1_id_priv" {
    value = azurerm_subnet.coderco_priv_subnet1.id
}

output "subnet2_id_priv" {
    value = azurerm_subnet.coderco_priv_subnet2.id
}

output "subnet3_id_priv" {
    value = azurerm_subnet.coderco_priv_subnet3.id
}

output "public_ip_id" {
  value = azurerm_public_ip.coderco_pub_ip.id
}

output "private_endpoint_id1" {
  value = azurerm_private_endpoint.storage_private_endpoint1.id
}

output "private_endpoint_id2" {
  value = azurerm_private_endpoint.storage_private_endpoint2.id
}

output "private_endpoint_id3" {
  value = azurerm_private_endpoint.storage_private_endpoint3.id
}

output "private_endpoint_ip_addresses" {
  value = [azurerm_private_endpoint.storage_private_endpoint1.private_service_connection[0].private_ip_address,
  azurerm_private_endpoint.storage_private_endpoint2.private_service_connection[0].private_ip_address,
  azurerm_private_endpoint.storage_private_endpoint3.private_service_connection[0].private_ip_address
  ]
}
