terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

# No-code modules are the ROOT of a generated workspace, so the provider MUST be configured here.
# Credentials come from a project-scoped variable set: ARM_CLIENT_ID, ARM_CLIENT_SECRET (sensitive),
# ARM_TENANT_ID, ARM_SUBSCRIPTION_ID (all as environment variables).
provider "azurerm" {
  features {}
}
