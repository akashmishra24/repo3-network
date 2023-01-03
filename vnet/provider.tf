terraform {
  backend "azurerm" {
    resource_group_name  = "rg-iac-cox-poc-01"
    storage_account_name = "tfstatedemo1"
    container_name       = "tfstate"
    key                  = "vnet.tfstate"
#     use_azuread_auth = true
  }
}

terraform {
  required_version = "1.3.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.3"
    }
  }
}

provider "azurerm" {
  use_msi = true
  tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  subscription_id = "7b5c7d11-8bc3-4105-9c6f-41222b38b95f"
  client_id = "a7f86a9f-b804-4844-8980-652cd145b25b"
  features {}
}

provider "azuread" {}
