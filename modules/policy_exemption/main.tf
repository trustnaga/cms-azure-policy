

resource "azurerm_management_group_policy_exemption" "mg" {
  count = var.enable && var.scope_type == "management_group" ? 1 : 0

  name                 = var.name
  management_group_id  = var.management_group_id
  policy_assignment_id  = var.policy_assignment_id
  exemption_category   = var.category

  display_name = var.display_name
  description  = var.description
  expires_on   = var.expires_on
  metadata     = var.metadata != null ? jsonencode(var.metadata) : null

  policy_definition_reference_ids = var.policy_definition_reference_ids
}




resource "azurerm_subscription_policy_exemption" "sub" {
  count = var.enable && var.scope_type == "subscription" ? 1 : 0

  name                 = var.name
  subscription_id      = var.subscription_id
  policy_assignment_id = var.policy_assignment_id
  exemption_category   = var.category

  display_name = var.display_name
  description  = var.description
  expires_on   = var.expires_on
  metadata     = var.metadata != null ? jsonencode(var.metadata) : null

  policy_definition_reference_ids = var.policy_definition_reference_ids
}



resource "azurerm_resource_group_policy_exemption" "rg" {
  count = var.enable && var.scope_type == "resource_group" ? 1 : 0

  name                 = var.name
  resource_group_id    = var.resource_group_id
  policy_assignment_id = var.policy_assignment_id
  exemption_category   = var.category

  display_name = var.display_name
  description  = var.description
  expires_on   = var.expires_on
  metadata     = var.metadata != null ? jsonencode(var.metadata) : null

  policy_definition_reference_ids = var.policy_definition_reference_ids
}



resource "azurerm_resource_policy_exemption" "res" {
  count = var.enable && var.scope_type == "resource" ? 1 : 0

  name                 = var.name
  resource_id          = var.resource_id
  policy_assignment_id = var.policy_assignment_id
  exemption_category   = var.category

  display_name = var.display_name
  description  = var.description
  expires_on   = var.expires_on
  metadata     = var.metadata != null ? jsonencode(var.metadata) : null

  policy_definition_reference_ids = var.policy_definition_reference_ids
}



