output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "adf_managed_identity_object_id" {
  value       = azurerm_data_factory.adf.identity[0].principal_id
}
