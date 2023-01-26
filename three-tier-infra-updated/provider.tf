terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "state-rg"
    storage_account_name = "tfstatethreetier"
    container_name       = "tfstate"
    key                  = "threetier.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}