
management_groups = [
  {
    name      = "CMS-Cloud"
    parent_id = "/providers/Microsoft.Management/managementGroups/140c2020-0158-4135-aba5-9f8c0485bdc6"
    assignments = [
      {
        name                 = "Allowed-locations"
        policy_source        = "builtin"
        policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
        
        parameters_json = "{\"listOfAllowedLocations\":{\"value\":[\"eastus\",\"eastus2\"]}}"

      },
      {
        name          = "custom-require-tag"
        policy_source = "custom"
        policy_path   = "policies/custom/custom-require-tag.json"
        parameters_json = "{\"tagName\":{\"value\":\"costCenter1\"}}"
      
      }
    ]
    exemptions = []
  },
  {
    name        = "GSS"
    parent_id   = "/providers/Microsoft.Management/managementGroups/CMS-Cloud"
    assignments = []
    exemptions  = []
  },
  {
    name        = "PROD"
    parent_id   = "/providers/Microsoft.Management/managementGroups/GSS"
    assignments = []
    exemptions  = [
      {
        name  = "Allowed-locations"
        assignment_name = "Allowed-locations"
        category = "Waiver"
        description = "Waiver for GSS "
      },
    {
        name  = "custom-require-tag"
        assignment_name = "custom-require-tag"
        category = "Waiver"
        description = "Waiver for GSS "
    }
    ]
  }
]




