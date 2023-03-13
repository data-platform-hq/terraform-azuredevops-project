locals {
  suffix = length(var.suffix) == 0 ? "" : "-${var.suffix}"
}

data "azuredevops_project" "existing" {
  count = var.existing_project_name != null ? 1 : 0
  name  = var.existing_project_name
}

resource "azuredevops_project" "this" {
  count              = var.existing_project_name == null ? 1 : 0
  name               = var.custom_ado_project_name != null ? var.custom_ado_project_name : "${var.project}-${var.env}-${var.location}${local.suffix}"
  visibility         = var.visibility
  version_control    = var.version_control
  work_item_template = var.work_item_template
  description        = var.description
  features           = var.features
}

resource "azuredevops_serviceendpoint_azurerm" "this" {
  count                 = var.service_endpoint_args == null ? 0 : 1
  project_id            = var.existing_project_name == null ? azuredevops_project.this[0].id : data.azuredevops_project.existing[0].id
  service_endpoint_name = var.custom_service_endpoint_name != null ? var.custom_service_endpoint_name : "(${var.service_endpoint_args.subscription_name})${var.service_endpoint_args.subscription_id}"
  description           = var.description
  credentials {
    serviceprincipalid  = var.service_endpoint_args.service_principal_id
    serviceprincipalkey = var.service_endpoint_args.service_principal_key
  }
  azurerm_spn_tenantid      = var.service_endpoint_args.spn_tenant_id
  azurerm_subscription_id   = var.service_endpoint_args.subscription_id
  azurerm_subscription_name = var.service_endpoint_args.subscription_name
}

resource "azuredevops_variable_group" "this" {
  count        = var.variables_set == [] ? 0 : 1
  project_id   = var.existing_project_name == null ? azuredevops_project.this[0].id : data.azuredevops_project.existing[0].id
  name         = var.custom_var_group_name != null ? var.custom_var_group_name : "var-group-${var.project}-${var.env}-${var.location}${local.suffix}"
  description  = var.description
  allow_access = true

  dynamic "variable" {
    for_each = var.variables_set
    content {
      name         = variable.value["name"]
      value        = variable.value["value"]
      secret_value = variable.value["secret_value"]
      is_secret    = coalesce(variable.value["is_secret"], true)
    }
  }
}
