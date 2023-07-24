output "id" {
  value       = try(azuredevops_agent_pool.this[0].id, null)
  description = "The ID of the agent pool."
}

output "name" {
  value       = try(azuredevops_agent_pool.this[0].name, null)
  description = "The Name of the agent pool."
}
