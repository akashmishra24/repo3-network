locals {
  if_ddos_enabled = var.create_ddos_plan ? [{}] : []
}

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.prefix}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = var.vnet_address_space
  dns_servers         = var.dns_server_ip
  tags                = var.tags

  dynamic "ddos_protection_plan" {
    for_each = local.if_ddos_enabled

    content {
      id     = azurerm_network_ddos_protection_plan.ddos[0].id
      enable = true
    }
  }
}

resource "azurerm_subnet" "snet" {
  for_each                    = var.subnets
  name                        = each.value["name"]
  resource_group_name         = data.azurerm_resource_group.rg.name
  virtual_network_name        = azurerm_virtual_network.vnet.name
  address_prefixes            = each.value["address_prefixes"]
  service_endpoints           = lookup(each.value, "service_endpoints", [])
  service_endpoint_policy_ids = lookup(each.value, "service_endpoint_policy_ids", null)
  # private_endpoint_network_policies_enabled     = lookup(each.value, "private_endpoint_network_policies_enabled", false)
  # private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", false)

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []
    content {
      name = lookup(each.value.delegation, "name", null)
      service_delegation {
        name    = lookup(each.value.delegation.service_delegation, "name", null)
        actions = lookup(each.value.delegation.service_delegation, "actions", null)
      }
    }
  }
}


resource "azurerm_network_ddos_protection_plan" "ddos" {
  count               = var.create_ddos_plan ? 1 : 0
  name                = var.ddos_plan_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tags                = var.tags
}
