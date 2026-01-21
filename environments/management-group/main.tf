locals {
  
 normalized_management_groups = [
    for mg in var.management_groups : {
      name        = mg.name
      parent_id   = try(mg.parent_id, null)
      assignments = try(mg.assignments, [])
      exemptions  = try(mg.exemptions, [])
    }
  ]

  management_groups_map = {
    for mg in local.normalized_management_groups :
    mg.name => mg
  }

 
 
  mg_parent_map = {
    for mg in local.normalized_management_groups :
    mg.name => mg.parent_id
  }
   # Normalize parent IDs to MG names (strip provider path)
  mg_parent_name_map = {
    for k, v in local.mg_parent_map :
    k => (
      v == null ? null :
      regex("[^/]+$", v)
    )
  }
  mg_ancestor_max_depth = 5

  management_group_assignments = {
      for assignment in flatten([
        for mg_name, mg in local.management_groups_map : [
          for a in mg.assignments : {
            key                  = "${mg_name}-${a.name}"
            management_group     = mg_name
            assignment_name      = a.name
            policy_source        = a.policy_source
            policy_definition_id = try(a.policy_definition_id, null)
            policy_path          = try(a.policy_path, null)
            parameters_json       = try(a.parameters_json, null)
            description          = try(a.description, null)
          }
        ]
      ]) : assignment.key => assignment
 }


  # Collect candidate objects
    custom_policy_objs = flatten([
      for mg_name, mg in local.management_groups_map : [
        for a in coalesce(mg.assignments, []) : {
          mg_name     = mg_name
          policy_path = a.policy_path
        }
        if try(a.policy_source, null) == "custom"
          && try(a.policy_path, null) != null
          && a.policy_path != ""
      ]
    ])


 custom_policy_map = {
    for obj in local.custom_policy_objs : obj.policy_path => obj
  }

  # Collect unique custom policies by path
 unique_custom_policies = values(local.custom_policy_map)

 
unique_custom_policies_map = {
    for obj in local.unique_custom_policies :
    "${obj.mg_name}:${obj.policy_path}" => obj
  }

 
}
 


data "azurerm_management_group" "this" {
  for_each = local.management_groups_map
  name       = each.value.name
}

# Create custom policy definitions
module "custom_policy_definition" {
  for_each = local.unique_custom_policies_map
  source   = "../../modules/policy_definition"
  name        = basename(each.value.policy_path)
  management_group_id = data.azurerm_management_group.this[each.value.mg_name].id
  policy_type = "Custom"
  policy_definition_path   = "../../${each.value.policy_path}"
}

# Assign policies (built-in or custom)
module "mg_policy_assignment" {
    source = "../../modules/policy_assignment"
    for_each = {
        for a in local.management_group_assignments :
        "${a.key}" => a
      }
     
      name  = each.value.assignment_name
      scope_type  = "management_group"
      management_group_id = data.azurerm_management_group.this[each.value.management_group].id
      
      # Use custom policy output if policy_source == "custom", otherwise use built-in policy_definition_id
      policy_definition_id = (
        each.value.policy_source == "custom"
        ? module.custom_policy_definition["${each.value.management_group}:${each.value.policy_path}"].policy_definition_id
        : each.value.policy_definition_id
      )  
      parameters = each.value.parameters_json
      description = try(each.value.description, null)
  
}

locals {

  assignment_id_map = {
    for k, m in module.mg_policy_assignment :
    k => m.policy_assignment_id
  }
}


locals {
  flattened_exemptions = flatten([
    for mg_name, mg in local.management_groups_map : [
      for e in mg.exemptions : {
        key                          = "${mg_name}-${e.name}"
        mg_name                      = mg_name
        name                         = e.name
        assignment_name              = e.assignment_name
        category                     = coalesce(try(e.category, null), "Waiver")
        description                  = try(e.description, null)
        # Optional extensions if you enabled them in variables:
        # expires_on                   = try(e.expires_on, null)
        # policy_definition_reference_ids = try(e.policy_definition_reference_ids, null)
        # metadata_json                = try(e.metadata_json, null)

        # Resolve the assignment key used by the assignment module
        assignment_key               = "${mg_name}-${e.assignment_name}"
        policy_assignment_id         = lookup(local.assignment_id_map, "${mg_name}-${e.assignment_name}", null)
      }
    ]
  ])

  
  #parent MG lookup  3 level CMS Cloud-->GSS-->PROD. Need got Logic to find the assignment.

  resolved_policy_assignment_ids = {
    for x in local.flattened_exemptions :
    x.key => coalesce(
      lookup(local.assignment_id_map, "${x.mg_name}-${x.assignment_name}", null),
      lookup(local.assignment_id_map, "${local.mg_parent_name_map[x.mg_name]}-${x.assignment_name}", null),
      
    # grandparent MG
      lookup(
        local.assignment_id_map,
        "${
          local.mg_parent_name_map[
            try(local.mg_parent_name_map[x.mg_name], "")
          ]
        }-${x.assignment_name}",
        null
      )

    )
  }
  
  finalized_exemptions = [
    for x in local.flattened_exemptions : merge(x, {
      policy_assignment_id = local.resolved_policy_assignment_ids[x.key]
    })
  ]


  policy_exemption_map = {
    for x in local.finalized_exemptions :
    x.key => x
  }
}



module "mg_policy_exemption" {
  for_each = local.policy_exemption_map
  source = "../../modules/policy_exemption"
  enable               = true
  name                 = each.value.name
  scope_type           = "management_group"
  management_group_id = data.azurerm_management_group.this[each.value.mg_name].id
  policy_assignment_id = each.value.policy_assignment_id

  category             = each.value.category
  description          = each.value.description
}


