terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.10.0"
    }
  }
}
