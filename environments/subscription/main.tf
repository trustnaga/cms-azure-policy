resource "azurerm_subscription" "example" {
  subscription_id = var.subscription_id
  display_name    = var.display_name
}

module "policy_definition" {
  source = "../../modules/policy_definition"

  name        = "example-policy"
  policy_type = "Custom"
  rules       = file("${path.module}/../../policies/custom/example-policy.json")
}

module "policy_assignment" {
  source = "../../modules/policy_assignment"

  scope                = azurerm_subscription.example.id
  policy_definition_id = module.policy_definition.policy_definition_id
}

module "policy_exemption" {
  source = "../../modules/policy_exemption"

  scope                = azurerm_subscription.example.id
  policy_definition_id = module.policy_definition.policy_definition_id
  exemption_name       = "example-exemption"
}