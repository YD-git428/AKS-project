module "storage" { 
  source = "../modules/storage"
  private_endpoint_id1 = module.vnet.private_endpoint_id1
  private_endpoint_id2 = module.vnet.private_endpoint_id2
  private_endpoint_id3 = module.vnet.private_endpoint_id3 
  priv_subnet_1 = module.vnet.subnet1_id_priv
  priv_subnet_2 = module.vnet.subnet2_id_priv
  priv_subnet3 = module.vnet.subnet3_id_priv
  resource_group_location = module.vnet.resource_group_location
  resource_group_name = module.vnet.resource_group_name 
}

module "vnet" {
  source = "../modules/vnet"
  pubip_sku = "Standard"
  allocation_method = "Static"
  vnetwork_name = "vnet"
  sec_rule1_name = "https-access"
  sec_rule2_name = "http-access"
  sec_rule3_name = "ssh-access"
  secgrp_name = "lb-sec-grp"
  rg_name = "coderco-azureproj"
  rg_location = "UK South"
  public_ip_name = "coderco-pubip"
  storage_account_id = module.storage.storage_acc_id
  subnet_priv_name1 = "private-subnet1"
  subnet_priv_name2 = "private-subnet2"
  subnet_priv_name3 = "private-subnet3"
  subnet_pub_name1 = "public-subnet1"
  subnet_pub_name2 = "public-subnet2"
  subnet_pub_name3 = "public-subnet3"

}

module "private_dns" {
  source = "../modules/dns"
  resource_group_name = module.vnet.resource_group_name
  vnet_id = module.vnet.vnet_id 
  primary_blob_endpoint = module.storage.blob_endpoint
  private_ip_addresses = module.vnet.private_endpoint_ip_addresses
}

output "location" {
  value = module.vnet.resource_group_location
}

output "resource_group_name" {
  value = module.vnet.resource_group_name
}

