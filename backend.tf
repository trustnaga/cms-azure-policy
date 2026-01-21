terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformstatepay"
    container_name       = "terraformstate"
    key                  = "management-group.tfstate"
  }
}