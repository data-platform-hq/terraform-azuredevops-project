variable "project" {
  type        = string
  description = "Project name. Used for resource name generation"
}

variable "env" {
  type        = string
  description = "Environment name. Used for resource name generation"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Used for resource name generation"
}

variable "suffix" {
  type        = string
  description = "Route table name suffix. Used for resource name generation"
  default     = ""
}

variable "visibility" {
  type        = string
  description = "Specifies the visibility of the Project."
  default     = "private"
  validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Valid values: private or public."
  }
}

variable "version_control" {
  type        = string
  description = "Specifies the version control system."
  default     = "Git"
  validation {
    condition     = contains(["Git", "Tfvc"], var.version_control)
    error_message = "Valid values: Git or Tfvc."
  }
}

variable "work_item_template" {
  type        = string
  description = "Valid values: Agile, Basic, CMMI, Scrum or a custom, pre-existing one. An empty string will use the parent organization default."
  default     = ""
}

variable "description" {
  type        = string
  description = "The Description of the Project."
  default     = "Terraform managed"
}

variable "existing_project_name" {
  type        = string
  description = "Name of existing project within Azure DevOps organisation. If provided new project will not be created."
  default     = null
}

variable "features" {
  type = object({
    boards       = optional(string)
    repositories = optional(string)
    pipelines    = optional(string)
    testplans    = optional(string)
    artifacts    = optional(string)
  })
  description = "Defines the status (enabled, disabled) of the project features. Valid features are boards, repositories, pipelines, testplans, artifacts. If not provided all features will be enabled."
  default     = null
}

variable "service_endpoint_args" {
  type = object({
    service_principal_id  = string
    service_principal_key = string
    spn_tenant_id         = string
    subscription_id       = string
    subscription_name     = string
  })
  description = "Mandatory arguments for service endpoint creation. If none of them is set, service endpoint will not be created."
  default     = null
  sensitive   = true
}

variable "custom_ado_project_name" {
  type        = string
  description = "ADO Project name that will be used instead of {var.project}-{var.env}-{var.location}{local.suffix} format."
  default     = null
}

variable "custom_var_group_name" {
  type        = string
  description = "Variable group name that will be used instead of var-group-{var.project}-{var.env}-{var.location}{local.suffix} format."
  default     = null
}

variable "custom_service_endpoint_name" {
  type        = string
  description = "Service endpoint name that will be used instead of ({var.subscription_name}){var.subscription_id} format"
  default     = null
}

variable "variables_set" {
  type = set(object({
    name         = string
    value        = optional(string)
    secret_value = optional(string)
    is_secret    = optional(bool)
  }))
  description = "Set of variables that will be added to Variable group in ADO project. If is_secret=true, secret_value should be provided instead of value. If is_secret is not provided, it is set to true bt default"
  default     = []
}
