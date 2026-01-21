

output "policy_exemptions_by_scope" {
  description = "All created exemption IDs grouped by scope."
  value = {
    management_group = { for k, v in azurerm_management_group_policy_exemption.mg  : k => v.id }
    subscription     = { for k, v in azurerm_subscription_policy_exemption.sub     : k => v.id }
    resource_group   = { for k, v in azurerm_resource_group_policy_exemption.rg    : k => v.id }
    resource         = { for k, v in azurerm_resource_policy_exemption.res         : k => v.id }
  }
}
