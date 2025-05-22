output "app_url" {
  description = "Public URL of the Azure Container App"
  value       = "https://${azurerm_container_app.this.latest_revision_fqdn}"
}