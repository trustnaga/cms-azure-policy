
output "management_groups" {
  value = {
    for k, mg in data.azurerm_management_group.this :
    k => {
      id   = mg.id
      name = mg.name
    }
  }
}


output "management_group_assignments" {
  value = local.management_group_assignments
}

