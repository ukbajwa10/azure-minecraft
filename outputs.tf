output "fqdn" {
  description = "Public FQDN players can use in their Hytale client."
  value       = azurerm_container_group.this.fqdn
}

output "public_ip" {
  description = "Public IP for the ACI (note: can change on recreation)."
  value       = azurerm_container_group.this.ip_address
}