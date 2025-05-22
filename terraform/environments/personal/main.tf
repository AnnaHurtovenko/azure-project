provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
}

module "container_app" {
  source              = "../../modules/container-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  container_image     = var.container_image
  container_app_name  = var.container_app_name
}

