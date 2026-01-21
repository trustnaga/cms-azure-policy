

variable "enable" {
  type        = bool
  description = "Whether to create a policy exemption"
  default     = false
}

variable "name" {
  type        = string
  description = "Policy exemption  name"
  default = null
}



variable "category" {
  type        = string
  description = "Waiver or Mitigated"
  default     = "Mitigated"

  validation {
    condition     = contains(["Waiver", "Mitigated"], var.category)
    error_message = "category must be Waiver or Mitigated."
  }
}


variable "display_name" {
  type    = string
  default = null
}




variable "description" {
  type        = string
  description = "Policy assignment Description"
  default     = null
}


variable "expires_on" {
  type    = string
  default = null
}

variable "metadata" {
  type    = map(any)
  default = null
}

variable "policy_assignment_id" {
   type    = string
}
variable "policy_definition_reference_ids" {
  type        = list(string)
  description = "Only used when exempting policies within an initiative"
  default     = null
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


