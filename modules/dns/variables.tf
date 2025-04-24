variable "vnet_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "primary_blob_endpoint" {
  type = string
}

variable "private_ip_addresses" {
  type = list(string)
}
