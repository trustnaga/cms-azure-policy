


resource "azurerm_management_group_policy_assignment" "mg" {
  count = var.scope_type == "management_group" ? 1 : 0

  name                 = var.name
  management_group_id  = var.management_group_id
  policy_definition_id = var.policy_definition_id
  parameters           = var.parameters
  description  = var.description
  
}



resource "azurerm_subscription_policy_assignment" "sub" {
  count = var.scope_type == "subscription" ? 1 : 0

  name                 = var.name
  subscription_id      = var.subscription_id
  policy_definition_id = var.policy_definition_id
  parameters           = var.parameters
  description  = var.description
  
}



resource "azurerm_resource_group_policy_assignment" "rg" {
  count = var.scope_type == "resource_group" ? 1 : 0

  name                 = var.name
  resource_group_id    = var.resource_group_id
  policy_definition_id = var.policy_definition_id
  parameters           = var.parameters 
  description  = var.description

}


resource "azurerm_resource_policy_assignment" "res" {
  count = var.scope_type == "resource" ? 1 : 0

  name                 = var.name
  resource_id          = var.resource_id
  policy_definition_id = var.policy_definition_id
  parameters           = var.parameters 
  description  = var.description
}




