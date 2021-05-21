terraform {
  required_version = ">= 0.15.4"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

//Criação do Resource Group
resource "azurerm_resource_group" "atividade02-terraform" {
    name     = "atividade02-terraform"
    location = "eastus"
}

