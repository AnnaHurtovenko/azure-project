variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "container_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "container_app_name" {
  description = "Name of the Azure Container App"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}