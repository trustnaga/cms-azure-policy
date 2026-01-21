variable "name" {
  description = "The name of the policy definition."
  type        = string
}

variable "policy_type" {
  description = "The type of the policy definition (e.g., Custom, BuiltIn)."
  type        = string
}

variable "policy_definition_path" {
  description = "The JSON rules for the policy definition."
  type        = string
}

variable "management_group_id" {
  type        = string
  description = "The id of the Management Group where this policy should be defined."
  default     = null
}