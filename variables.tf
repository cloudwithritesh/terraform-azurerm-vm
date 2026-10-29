# Variables WITHOUT defaults can get dropdown options when no-code is enabled.

variable "vm_name" {
  type        = string
  description = "Short VM name (lowercase letters, numbers, hyphens)"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,30}$", var.vm_name))
    error_message = "vm_name must be 3-30 chars: lowercase letters, numbers, hyphens."
  }
}

variable "environment" {
  type        = string
  description = "Environment (dropdown: dev, test, prod)"
}

variable "location" {
  type        = string
  description = "Azure region (dropdown)"
}

variable "vm_size" {
  type        = string
  description = "VM size (dropdown)"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}
