#This is a resource group which is a container of resources such as VMs or storage accounts etc
resource "azurerm_resource_group" "coderco" {
  name     = var.rg_name
  location = var.rg_location
}

#This is a virtual network which is an isolated network which allows communication between resources
resource "azurerm_virtual_network" "coderco_vnet" {
  name                = var.vnetwork_name
  location            = azurerm_resource_group.coderco.location
  resource_group_name = azurerm_resource_group.coderco.name
  address_space       = ["10.0.0.0/16"]
}

#A subnet is located within a virtual network and contains its own IP addresses which are assigned to resources for communication
resource "azurerm_subnet" "coderco_pub_subnet1" {
  name                 = var.subnet_pub_name1
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "coderco_pub_subnet2" {
  name                 = var.subnet_pub_name2
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "coderco_pub_subnet3" {
  name                 = var.subnet_pub_name3
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "coderco_priv_subnet1" {
  name                 = var.subnet_priv_name1
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.4.0/24"]

  private_endpoint_network_policies = "Enabled"
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "coderco_priv_subnet2" {
  name                 = var.subnet_priv_name2
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.5.0/24"]

  private_endpoint_network_policies = "Enabled"
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "coderco_priv_subnet3" {
  name                 = var.subnet_priv_name3
  resource_group_name  = azurerm_resource_group.coderco.name
  virtual_network_name = azurerm_virtual_network.coderco_vnet.name
  address_prefixes     = ["10.0.6.0/24"]

  private_endpoint_network_policies = "Enabled"
  service_endpoints = ["Microsoft.Storage"]
}

#A public ip to connect your virtual network to the internet
resource "azurerm_public_ip" "coderco_pub_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.coderco.location
  resource_group_name = azurerm_resource_group.coderco.name
  allocation_method   = var.allocation_method
  sku                 = var.pubip_sku
  zones = ["1", "2", "3"]
}

resource "azurerm_network_security_group" "lb_securitygrp" {
  name = var.secgrp_name
  location = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_network_security_rule" "coderco_https" {
  name                        = var.sec_rule1_name
  resource_group_name         = azurerm_resource_group.coderco.name
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.lb_securitygrp.name
}

resource "azurerm_network_security_rule" "coderco_http" {
  name                        = var.sec_rule2_name
  resource_group_name         = azurerm_resource_group.coderco.name
  priority                    = 105
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.lb_securitygrp.name
}

resource "azurerm_network_security_rule" "coderco_ssh" {
  name                        = var.sec_rule3_name
  description                 = "inbound ssh access"
  resource_group_name         = azurerm_resource_group.coderco.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.lb_securitygrp.name
}


resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc1" {
  subnet_id                 = azurerm_subnet.coderco_pub_subnet1.id
  network_security_group_id = azurerm_network_security_group.lb_securitygrp.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc2" {
  subnet_id                 = azurerm_subnet.coderco_pub_subnet2.id
  network_security_group_id = azurerm_network_security_group.lb_securitygrp.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc3" {
  subnet_id                 = azurerm_subnet.coderco_pub_subnet3.id
  network_security_group_id = azurerm_network_security_group.lb_securitygrp.id
}

resource "azurerm_nat_gateway" "nat_gateway1" {
  name                    = "nat-gateway"
  location                = azurerm_resource_group.coderco.location
  resource_group_name     = azurerm_resource_group.coderco.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["3"]
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pub_ip_assoc" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway1.id
  public_ip_address_id = azurerm_public_ip.coderco_pub_ip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assoc1" {
  subnet_id      = azurerm_subnet.coderco_pub_subnet1.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway1.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assoc2" {
  subnet_id      = azurerm_subnet.coderco_pub_subnet2.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway1.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assoc3" {
  subnet_id      = azurerm_subnet.coderco_pub_subnet3.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway1.id
}


resource "azurerm_private_endpoint" "storage_private_endpoint1" {
  name                = "StoragePrivateEndpoint1"
  location            = azurerm_resource_group.coderco.location
  resource_group_name = azurerm_resource_group.coderco.name
  subnet_id           = azurerm_subnet.coderco_priv_subnet1.id

  private_service_connection {
    name                           = "StoragePrivateConnection1"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"] 
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "storage_private_endpoint2" {
  name                = "StoragePrivateEndpoint2"
  location            = azurerm_resource_group.coderco.location
  resource_group_name = azurerm_resource_group.coderco.name
  subnet_id           = azurerm_subnet.coderco_priv_subnet2.id

  private_service_connection {
    name                           = "StoragePrivateConnection2"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"] 
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "storage_private_endpoint3" {
  name                = "StoragePrivateEndpoint3"
  location            = azurerm_resource_group.coderco.location
  resource_group_name = azurerm_resource_group.coderco.name
  subnet_id           = azurerm_subnet.coderco_priv_subnet3.id

  private_service_connection {
    name                           = "StoragePrivateConnection3"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"] 
    is_manual_connection           = false
  }
}


