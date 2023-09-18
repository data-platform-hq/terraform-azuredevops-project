data "azuredevops_project" "this" {
  name = var.project_name
}

# Pipelines source repos
data "azuredevops_git_repository" "this" {
  for_each = toset(var.pipeline_configs[*].pipeline_source_config.repository_name)

  project_id = data.azuredevops_project.this.id
  name       = each.value

  depends_on = [azuredevops_git_repository.import]
}

# default environment approvers group
data "azuredevops_group" "this" {
  project_id = data.azuredevops_project.this.id
  name       = var.environments_approvers
}