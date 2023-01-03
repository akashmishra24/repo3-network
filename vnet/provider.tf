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
      version = "3.35.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.3"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  client_id = "0cffc591-20bd-42b4-b2f5-292ba2b04a1d"
  tenant_id = "72f988bf-86f1-41af-91ab-2d7cd011db47"
  subscription_id = "7b5c7d11-8bc3-4105-9c6f-41222b38b95f"
  features {}
}

provider "azuread" {}
