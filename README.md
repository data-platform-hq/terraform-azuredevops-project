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
| Name                                                                            | Version  |
|---------------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform)       | >= 1.0.0 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.6.0 |

## Providers

| Name                                                                            | Version  |
|---------------------------------------------------------------------------------|----------|
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.6.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                    | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azuredevops_project.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/project)                                 | resource |
| [azuredevops_serviceendpoint_azurerm.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/serviceendpoint_azurerm) | resource |
| [azuredevops_variable_group.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/variable_group)                   | resource |
| [azuredevops_agent_pool.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/agent_pool)                           | resource |
| [azuredevops_agent_queue.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/agent_queue)                         | resource |
| [azuredevops_resource_authorization.this](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/resource_authorization)   | resource |

## Inputs

| Name                                                                                                                       | Description                                                                                                                                                                                           | Type                                                                                                                                                                                                                                                                                                                                                                         | Default             | Required |
|----------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|:--------:|
| <a name="input_project"></a> [project](#input\_project) | Project name | `string`| n/a | yes |
| <a name="input_env"></a> [env](#input\_env)                                                                                | Environment name                                                                                                                                                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                     | n/a                 |   yes    |
| <a name="input_location"></a> [location](#input\_location)                                                                 | Azure location                                                                                                                                                                                        | `string`                                                                                                                                                                                                                                                                                                                                                                     | n/a                 |   yes    |
| <a name="input_suffix"></a> [suffix](#input\_suffix)                                                                       | Route table name suffix                                                                                                                                                                               | `string`                                                                                                                                                                                                                                                                                                                                                                     | `""`                |    no    |
| <a name="input_visibility"></a> [visibility](#input\_visibility)                                                           | Specifies the visibility of the Project.                                                                                                                                                              | `string`                                                                                                                                                                                                                                                                                                                                                                     | `private`           |    no    |
| <a name="input_version_control"></a> [version\_control](#input\_version\_control)                                          | Specifies the version control system.                                                                                                                                                                 | `string`                                                                                                                                                                                                                                                                                                                                                                     | `Git`               |    no    |
| <a name="input_work_item_template"></a> [work\_item\_template](#input\_work\_item\_template)                               | Valid values: Agile, Basic, CMMI, Scrum or a custom, pre-existing one. An empty string will use the parent organization default.                                                                      | `string`                                                                                                                                                                                                                                                                                                                                                                     | `""`                |    no    |
| <a name="input_description"></a> [description](#input\_description)                                                        | The Description for ADO Project, service endpoint, variable group.                                                                                                                                    | `string`                                                                                                                                                                                                                                                                                                                                                                     | `Terraform managed` |    no    |
| <a name="input_create_service_endpoints"></a> [create\_service\_endpoints](#input\_create\_service\_endpoints)             | Boolean flag to turn off service endpoints creation.                                                                                                                                                  | `boolean`                                                                                                                                                                                                                                                                                                                                                                    | `true`              |    no    |
| <a name="input_existing_project_name"></a> [existing\_project\_name](#input\_existing\_project\_name)                      | Name of existing project within Azure DevOps organisation. If provided new project will not be created.                                                                                               | `string`                                                                                                                                                                                                                                                                                                                                                                     | `null`              |    no    |
| <a name="input_features"></a> [features](#input\_features)                                                                 | Defines the status (enabled, disabled) of the project features. Valid features are boards, repositories, pipelines, testplans, artifacts. If not provided all features will be enabled.               | <pre>map(object({<br> boards       = optional(string) <br> repositories = optional(string) <br> pipelines    = optional(string)<br> testplans    = optional(string) <br> artifacts    = optional(string) <br>}))</pre>                                                                                                                                                       | `null`              |    no    |
| <a name="input_service_endpoint_args"></a> [service\_endpoint\_args](#input\_service\_endpoint\_args)                      | Arguments for service endpoint creation. If none of them is set, service endpoint will not be created.                                                                                                | <pre>map(object({<br> service_principal_id         = string <br> service_principal_key        = string <br> spn_tenant_id                = string<br> subscription_id              = string <br> subscription_name            = string <br> environment                  = optional(string, "AzureCloud") <br> custom_service_endpoint_name = optional(string) <br>}))</pre> | `null`              |    no    |
| <a name="input_custom_ado_project_name"></a> [custom\_ado\_project\_name](#input\_custom\_ado\_project\_name)              | ADO Project name that will be used instead of {var.project}-{var.env}-{var.location}{local.suffix} format.                                                                                            | `string`                                                                                                                                                                                                                                                                                                                                                                     | `null`              |    no    |
| <a name="input_custom_var_group_name"></a> [custom\_var\_group\_name](#input\_custom\_var\_group\_name)                    | Variable group name that will be used instead of var-group-{var.project}-{var.env}-{var.location}{local.suffix} format.                                                                               | `string`                                                                                                                                                                                                                                                                                                                                                                     | `null`              |    no    |
| <a name="input_variables_set"></a> [variables\_set](#input\_variables\_set)                                                | Set of variables that will be added to Variable group in ADO project. If is_secret=true, secret_value should be provided instead of value. If is_secret is not provided, it is set to true bt default | <pre>set(object({<br> name         = string <br> value        = optional(string) <br> secret_value = optional(string)<br> is_secret    = bool <br>}))</pre>                                                                                                                                                                                                                  | `[]`                |    no    |
| <a name="input_self_hosted_linux_agent_enable"></a> [self\_hosted\_linux\_agent\_enable](#input\_self\_hosted\_linux\_agent\_enable) | Self hosted linux agent enable | `bool` | `false` | no |
| <a name="input_pool_configuration"></a> [pool\_configuration](#input\_pool\_configuration) | Objects to configure pool | <pre>object({<br>  agent_name     = string<br>  auto_provision = optional(bool)<br>  auto_update    = optional(bool)<br>})</pre> | <pre>{<br>  agent_name     = "self_hosted_agent_pool"<br>  auto_provision = false<br>  auto_update    = true<br>}</pre> | no |
| <a name="input_pool_authorization"></a> [pool\_authorization](#input\_pool\_authorization) | Objects to configure pool authorization | <pre>object({<br>  type       = string<br>  authorized = bool<br>})</pre> | <pre>{<br>  type       = "queue"<br>  authorized = true<br>}</pre> | no |

<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azuredevops-project/blob/main/LICENSE)
