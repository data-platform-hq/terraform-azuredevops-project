output "id" {
  value       = try(azuredevops_agent_pool.this[0].id, null)
  description = "The ID of the agent pool."
}

output "name" {
  value       = try(azuredevops_agent_pool.this[0].name, null)
  description = "The Name of the agent pool."
}

output "service_connection_name" {
  value       = [for item in keys(local.service_endpoints_azurerm_mapped) : azuredevops_serviceendpoint_azurerm.this[item].service_endpoint_name]
  description = "Service Endpoints AzureRM names list"
}
