# TODO - Update Documentation
# Azure DevOps project Terraform module
Terraform module for creation Azure DevOps project service endpoint and variable group in existing Azure DevOps organisation. After variable group creation in ADO, any changes to it are ignored by terraform.

## Usage
This module is creating ADO project, service endpoint and variable group or creates service endpoint and variable group in existing project. Below is an example that provisions project variable group and service connection.
```hcl
data "azurerm_client_config" "current" {}
module "ado_project" {
  source  = "data-platform-hq/project/azuredevops"
  project  = "my_project"
  env      = "dev"
  location = "westeurope"
  features = {
    boards    = "disabled"
    testplans = "disabled"
  }
  # var1 has value and is not a secret, var2 has value and is a secret, 
  # var3 is empty and is not a secret, var4 is empty and is a secret
  variables_set = [
    {
      name      = "var1"
      value     = "value1"
      is_secret = false
    },
    {
      name         = "var2"
      secret_value = "value2"
    },
    {
      name = "var3"
      is_secret = false
    },
    {
      name = "var4"
    }
  ]
  # var.infra-arm-client-id, var.infra-arm-tenant-id, var.infra-arm-subscription-id are empty by default. 
  # Client configuration values will be used instead.
  service_endpoint_args = [
    {
      service_principal_key        = "some_service_principal_key"
      service_principal_id         = coalesce(var.infra_arm_client_id, data.azurerm_client_config.current.client_id)
      spn_tenant_id                = coalesce(var.infra_arm_tenant_id, data.azurerm_client_config.current.tenant_id)
      subscription_id              = coalesce(var.infra_arm_subscription_id, data.azurerm_client_config.current.subscription_id)
      subscription_name            = "some_subscription_name"
      custom_service_endpoint_name = "service-principal-dev"
    }
  ]
  # project will have name "some_project_name" instead of "my_project-dev-westeurope".
  custom_ado_project_name      = "some_project_name"
  
  # Variable group will have name "our_default_pipeline_var_group" instead of "var-group-my_project-dev-westeurope".
  custom_var_group_name        = "our_default_pipeline_var_group"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 1.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuredevops"></a> [azuredevops](#provider\_azuredevops) | >= 1.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_agent_pool.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/agent_pool) | resource |
| [azuredevops_agent_queue.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/agent_queue) | resource |
| [azuredevops_build_definition.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/build_definition) | resource |
| [azuredevops_check_approval.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/check_approval) | resource |
| [azuredevops_environment.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/environment) | resource |
| [azuredevops_feed.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/feed) | resource |
| [azuredevops_feed_permission.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/feed_permission) | resource |
| [azuredevops_git_repository.import](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_repository) | resource |
| [azuredevops_group_membership.example](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/group_membership) | resource |
| [azuredevops_pipeline_authorization.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/pipeline_authorization) | resource |
| [azuredevops_resource_authorization.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/resource_authorization) | resource |
| [azuredevops_serviceendpoint_azurerm.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_serviceendpoint_generic_git.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_generic_git) | resource |
| [azuredevops_variable_group.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/variable_group) | resource |
| [azuredevops_git_repository.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/git_repository) | data source |
| [azuredevops_group.build](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.feed](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_group.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/group) | data source |
| [azuredevops_project.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/project) | data source |
| [azuredevops_users.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/data-sources/users) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ado_feed"></a> [ado\_feed](#input\_ado\_feed) | Set of objects with parameters to configure feed and assign permissions | <pre>set(object({<br>    feed_name                      = string<br>    permanent_feed_delete          = optional(bool, true)<br>    feed_permission_group_role     = optional(string, "contributor")<br>    feed_scope_organization_enable = optional(bool, false)<br>    feed_permission_group_name     = string<br>  }))</pre> | `[]` | no |
| <a name="input_builder_service_principal_name"></a> [builder\_service\_principal\_name](#input\_builder\_service\_principal\_name) | Default project's Service Builder name | `string` | `null` | no |
| <a name="input_builder_service_role_assigned"></a> [builder\_service\_role\_assigned](#input\_builder\_service\_role\_assigned) | Boolean flag that determines whether to assign permission to a default project's Service Builder | `bool` | `false` | no |
| <a name="input_environments_approvers"></a> [environments\_approvers](#input\_environments\_approvers) | Default Azure DevOps Group that is allowed to approve deployments on Environments | `string` | `"Contributors"` | no |
| <a name="input_imported_repositories"></a> [imported\_repositories](#input\_imported\_repositories) | Configuration options for External Repositories. | <pre>list(object({<br>    given_name     = string<br>    repository_url = string<br>    password       = string<br>  }))</pre> | `[]` | no |
| <a name="input_pipeline_configs"></a> [pipeline\_configs](#input\_pipeline\_configs) | Configuration options for Pipeline yml definition files | <pre>list(object({<br>    name         = string<br>    folder       = optional(string, null)<br>    environments = optional(list(string), [])<br>    pipeline_source_config = object({<br>      repository_name = string<br>      branch_name     = optional(string, "refs/heads/main")<br>      yml_path        = string<br>    })<br>    variables = optional(list(object({<br>      name           = string<br>      value          = string<br>      allow_override = optional(bool, true)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_pool_authorization"></a> [pool\_authorization](#input\_pool\_authorization) | Object with parameters to configure authorization of self-hosted agent pool | <pre>object({<br>    type       = string<br>    authorized = bool<br>  })</pre> | <pre>{<br>  "authorized": true,<br>  "type": "queue"<br>}</pre> | no |
| <a name="input_pool_configuration"></a> [pool\_configuration](#input\_pool\_configuration) | Object with parameters to configure self-hosted agent pool | <pre>object({<br>    name           = string                # The name of the agent pool.<br>    auto_provision = optional(bool, false) # Specifies whether a queue should be automatically provisioned for each project collection.<br>    auto_update    = optional(bool, true)  # Specifies whether or not agents within the pool should be automatically updated<br>  })</pre> | <pre>{<br>  "name": "self_hosted_agent_pool"<br>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of Azure DevOps Project where infrastructure would be provisioned | `string` | n/a | yes |
| <a name="input_self_hosted_linux_agent_enable"></a> [self\_hosted\_linux\_agent\_enable](#input\_self\_hosted\_linux\_agent\_enable) | Boolean flag to determine whether to create resources required for Self Hosted Agent | `bool` | `false` | no |
| <a name="input_service_endpoint_azurerm"></a> [service\_endpoint\_azurerm](#input\_service\_endpoint\_azurerm) | Configuration options for AzureRM Service Endpoint | <pre>list(object({<br>    name                  = string<br>    service_principal_id  = string<br>    service_principal_key = string<br>    spn_tenant_id         = string<br>    subscription_id       = string<br>    subscription_name     = string<br>    description           = optional(string)<br>    environment           = optional(string, "AzureCloud")<br>  }))</pre> | `[]` | no |
| <a name="input_variables_groups"></a> [variables\_groups](#input\_variables\_groups) | Configuration options for Variable group | <pre>list(object({<br>    name         = string<br>    description  = optional(string)<br>    allow_access = optional(bool, true)<br>    variables = list(object({<br>      name         = string<br>      value        = optional(string)<br>      secret_value = optional(string)<br>      is_secret    = optional(bool, false)<br>    }))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the agent pool. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the agent pool. |
| <a name="output_service_connection_name"></a> [service\_connection\_name](#output\_service\_connection\_name) | Service Endpoints AzureRM names list |
<!-- END_TF_DOCS -->

## License
Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azuredevops-project/blob/main/LICENSE)
