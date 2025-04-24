output "storage_acc_id" {
  value = azurerm_storage_account.az_storage_account.id
}

output "blob_endpoint" {
  value = azurerm_storage_account.az_storage_account.primary_blob_endpoint
}