
variable "name" {
  type        = string
  description = "Policy assignment name"
}

variable "description" {
  type        = string
  description = "Policy assignment Description"
  default     = null
}

variable "policy_definition_id" {
  type        = string
  description = "Policy or Initiative definition ID"
}

variable "scope_type" {
  type        = string
  description = "Scope type: management_group | subscription | resource_group | resource"
  validation {
    condition     = contains(["management_group", "subscription", "resource_group", "resource"], var.scope_type)
    error_message = "scope_type must be one of: management_group, subscription, resource_group, resource."
  }
}

variable "management_group_id" {
  type        = string
  default     = null
}

variable "subscription_id" {
  type        = string
  default     = null
}

variable "resource_group_id" {
  type        = string
  default     = null
}

variable "resource_id" {
  type        = string
  default     = null
}

variable "parameters" {
  type        = any
  default     = null
}


