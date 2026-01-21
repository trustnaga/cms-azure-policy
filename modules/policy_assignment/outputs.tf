
output "policy_assignment_id" {
  value = coalesce(
    try(azurerm_management_group_policy_assignment.mg[0].id, null),
    try(azurerm_subscription_policy_assignment.sub[0].id, null),
    try(azurerm_resource_group_policy_assignment.rg[0].id, null),
    try(azurerm_resource_policy_assignment.res[0].id, null)
  )
}
