variable "project_name" {
  description = "The name of Azure DevOps Project where infrastructure would be provisioned"
  type        = string
}

# Service Connection with type AzureRM
variable "service_endpoint_azurerm" {
  description = "Configuration options for AzureRM Service Endpoint"
  type = list(object({
    name                  = string
    service_principal_id  = string
    service_principal_key = string
    spn_tenant_id         = string
    subscription_id       = string
    subscription_name     = string
    description           = optional(string)
    environment           = optional(string, "AzureCloud")
  }))
  default = []
}

# Variable groups
variable "variables_groups" {
  description = "Configuration options for Variable group"
  type = list(object({
    name         = string
    description  = optional(string)
    allow_access = optional(bool, true)
    variables = list(object({
      name         = string
      value        = optional(string)
      secret_value = optional(string)
      is_secret    = optional(bool, false)
    }))
  }))
  default = []
}

# Self Hoster Agent Pool
variable "self_hosted_linux_agent_enable" {
  type        = bool
  description = "Boolean flag to determine whether to create resources required for Self Hosted Agent"
  default     = false
}

variable "pool_configuration" {
  type = object({
    name           = string                # The name of the agent pool.
    auto_provision = optional(bool, false) # Specifies whether a queue should be automatically provisioned for each project collection.
    auto_update    = optional(bool, true)  # Specifies whether or not agents within the pool should be automatically updated
  })
  description = "Object with parameters to configure self-hosted agent pool"
  default = {
    name = "self_hosted_agent_pool"
  }
}

variable "pool_authorization" {
  type = object({
    type       = string
    authorized = bool
  })
  description = "Object with parameters to configure authorization of self-hosted agent pool"
  default = {
    type       = "queue"
    authorized = true
  }
}

# Import external repositories
variable "imported_repositories" {
  description = "Configuration options for External Repositories."
  type = list(object({
    given_name     = string
    repository_url = string
    password       = string
  }))
  default = []
}

# Pipelines creation for repository
variable "pipeline_configs" {
  description = "Configuration options for Pipeline yml definition files"
  type = list(object({
    name         = string
    folder       = optional(string, null)
    environments = optional(list(string), [])
    pipeline_source_config = object({
      repository_name = string
      branch_name     = optional(string, "refs/heads/main")
      yml_path        = string
    })
    variables = optional(list(object({
      name           = string
      value          = string
      allow_override = optional(bool, true)
    })), [])
  }))
  default = []
}

variable "environments_approvers" {
  description = "Default Azure DevOps Group that is allowed to approve deployments on Environments"
  type        = string
  default     = "Contributors"
}

# Builder Service permissions
variable "builder_service_principal_name" {
  type        = string
  description = "Default project's Service Builder name"
  default     = null
}

variable "builder_service_role_assigned" {
  description = "Boolean flag that determines whether to assign permission to a default project's Service Builder"
  type        = bool
  default     = false
}

variable "ado_feed" {
  type = set(object({
    feed_name                      = string
    permanent_feed_delete          = optional(bool, true)
    feed_permission_group_role     = optional(string, "contributor")
    feed_scope_organization_enable = optional(bool, false)
    feed_permission_group_name     = string
  }))
  description = "Set of objects with parameters to configure feed and assign permissions"
  default     = []
}
