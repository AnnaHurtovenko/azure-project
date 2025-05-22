resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_app_environment" "this" {
  name                = "${var.container_app_name}-env"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_container_app" "this" {
  name                         = var.container_app_name
  resource_group_name          = azurerm_resource_group.this.name
  container_app_environment_id = azurerm_container_app_environment.this.id
  revision_mode                = "Single"

  template {
    container {
      name   = "fastapi"
      image  = var.container_image
      cpu    = 0.5
      memory = "1.0Gi"
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
