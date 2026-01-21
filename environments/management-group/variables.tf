

variable "management_groups" {
  description = <<DESC
List of management groups with optional policy assignments and exemptions.
Used to create or manage Azure Management Group hierarchy and governance.
DESC

  type = list(object({
    name = string

    # Parent management group ID
    parent_id = optional(string)

    # Policy Assignments at Management Group scope
    assignments = optional(list(object({
      name = string

      # Source of the policy (builtin | custom | initiative)
      policy_source = string

      # Required for builtin policies / initiatives
      policy_definition_id = optional(string)

      # Used when policy_source = "custom" or initiative path lookup
      policy_path = optional(string)

      parameters_json      = optional(string) # only JSON string accepted

      description = optional(string)
    })), [])

    # Policy Exemptions at Management Group scope
    exemptions = optional(list(object({
      name            = string
      assignment_name = string
      category        = optional(string)
      description     = optional(string)
    })), [])
  }))
}

