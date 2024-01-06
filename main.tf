locals {
  variable_groups_mapped           = { for object in var.variables_groups : object.name => object if length(object.name) != 0 }
  service_endpoints_azurerm_mapped = nonsensitive({ for object in var.service_endpoint_azurerm : object.name => object if length(object.name) != 0 })
  imported_repositories_mapped     = { for object in var.imported_repositories : object.given_name => object }
  pipeline_config_mapped           = { for config in var.pipeline_configs : config.name => config if config.name != null }

  environments_set = toset(distinct(flatten(var.pipeline_configs[*].environments)))

  environments_pipeline_authorization = { for object in flatten([for k, v in local.pipeline_config_mapped : [for pair in setproduct([k], v.environments) : {
    pipeline_name = pair[0], env_name = pair[1]
  }]]) : "${object.pipeline_name}:${object.env_name}" => object if object.pipeline_name != null }

  # Builder Service permission assignment
  build_sp_name       = "${var.project_name} Build Service (${trimprefix(data.azuredevops_client_config.this.organization_url, "https://dev.azure.com/")})"
  build_server_params = var.builder_service_role_assigned ? merge({ for object in data.azuredevops_users.this[0].users : object.display_name => object })[local.build_sp_name] : {}
}

# Service Endpoint AzureRM
resource "azuredevops_serviceendpoint_azurerm" "this" {
  for_each = local.service_endpoints_azurerm_mapped

  project_id            = data.azuredevops_project.this.id
  service_endpoint_name = each.value.name
  description           = each.value.description
  environment           = each.value.environment

  credentials {
    serviceprincipalid  = each.value.service_principal_id
    serviceprincipalkey = each.value.service_principal_key
  }

  azurerm_spn_tenantid      = each.value.spn_tenant_id
  azurerm_subscription_id   = each.value.subscription_id
  azurerm_subscription_name = each.value.subscription_name
}

resource "azuredevops_variable_group" "this" {
  for_each = local.variable_groups_mapped

  project_id   = data.azuredevops_project.this.id
  name         = each.value.name
  description  = each.value.description
  allow_access = each.value.allow_access

  dynamic "variable" {
    for_each = nonsensitive(each.value.variables)
    content {
      name         = variable.value.name
      value        = variable.value.value
      secret_value = variable.value.secret_value
      is_secret    = variable.value.is_secret
    }
  }
}

# Self Hosted Agent Pool
resource "azuredevops_agent_pool" "this" {
  count = var.self_hosted_linux_agent_enable ? 1 : 0

  name           = var.pool_configuration.name
  auto_provision = var.pool_configuration.auto_provision
  auto_update    = var.pool_configuration.auto_update
}

resource "azuredevops_agent_queue" "this" {
  count = var.self_hosted_linux_agent_enable ? 1 : 0

  project_id    = data.azuredevops_project.this.id
  agent_pool_id = azuredevops_agent_pool.this[0].id
}

resource "azuredevops_resource_authorization" "this" {
  count = var.self_hosted_linux_agent_enable ? 1 : 0

  project_id  = data.azuredevops_project.this.id
  resource_id = azuredevops_agent_queue.this[0].id
  type        = var.pool_authorization.type
  authorized  = var.pool_authorization.authorized

  depends_on = [azuredevops_agent_queue.this]
}

# Imported Repos
resource "azuredevops_serviceendpoint_generic_git" "this" {
  for_each = local.imported_repositories_mapped

  project_id            = data.azuredevops_project.this.id
  repository_url        = each.value.repository_url
  password              = each.value.password
  service_endpoint_name = each.value.given_name
  description           = "Managed by Terraform"
}

resource "azuredevops_git_repository" "import" {
  for_each = local.imported_repositories_mapped

  project_id = data.azuredevops_project.this.id
  name       = each.value.given_name

  initialization {
    init_type             = "Import"
    source_type           = "Git"
    source_url            = each.value.repository_url
    service_connection_id = azuredevops_serviceendpoint_generic_git.this[each.key].id
  }
}

# Pipeline definitions
resource "azuredevops_build_definition" "this" {
  for_each = local.pipeline_config_mapped

  project_id = data.azuredevops_project.this.id
  name       = each.value.name
  path       = each.value.folder

  repository {
    repo_type   = "TfsGit"
    repo_id     = data.azuredevops_git_repository.this[each.value.pipeline_source_config.repository_name].id
    branch_name = each.value.pipeline_source_config.branch_name
    yml_path    = each.value.pipeline_source_config.yml_path
  }

  dynamic "variable" {
    for_each = each.value.variables
    content {
      name           = variable.value.name
      value          = variable.value.value
      allow_override = variable.value.allow_override
    }
  }

  ci_trigger {
    use_yaml = true
  }
}

# Deployment environments
resource "azuredevops_environment" "this" {
  for_each = local.environments_set

  name       = each.value
  project_id = data.azuredevops_project.this.id
}

resource "azuredevops_check_approval" "this" {
  for_each = local.environments_set

  project_id           = data.azuredevops_project.this.id
  target_resource_id   = azuredevops_environment.this[each.value].id
  target_resource_type = "environment"

  requester_can_approve = true

  approvers = [
    data.azuredevops_group.this.origin_id
  ]
}

resource "azuredevops_pipeline_authorization" "this" {
  for_each = local.environments_pipeline_authorization

  project_id  = data.azuredevops_project.this.id
  resource_id = azuredevops_environment.this[each.value.env_name].id
  type        = "environment"
  pipeline_id = azuredevops_build_definition.this[each.value.pipeline_name].id
}

# Builder Service permission assignment
resource "azuredevops_group_membership" "example" {
  count = var.builder_service_role_assigned ? 1 : 0

  group = data.azuredevops_group.build[0].descriptor
  members = [
    local.build_server_params["descriptor"]
  ]
}
