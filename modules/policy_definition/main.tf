locals{
  policy_full = jsondecode(file(var.policy_definition_path))
  props       = local.policy_full.properties
}


resource "azurerm_policy_definition" "example" {
  name         = var.name
  display_name = local.props.displayName
  policy_type  = coalesce(local.props.policyType, "Custom")
  mode         = coalesce(local.props.mode, "Indexed")
  description  = try(local.props.description, null)

  
  #IMPORTANT: azurerm requires strings here
  parameters  = jsonencode(try(local.props.parameters, {}))
  policy_rule = jsonencode(local.props.policyRule)

  # Optional: pass metadata if you want
  metadata = jsonencode(try(local.props.metadata, {}))
  management_group_id=try(var.management_group_id, null)

}

