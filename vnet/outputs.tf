output "virtual_network_id" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "virtual_network_name" {
  description = "The id of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "List of IDs of subnets"
  value       = [for s in azurerm_subnet.snet : s.id]
}
