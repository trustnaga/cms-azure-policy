terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
  subscription_id = "90605107-5c6f-4a55-b0cd-54418fb2119f"
}