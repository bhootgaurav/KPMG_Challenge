resource "azurerm_subnet" "three-tier-subnets" {
  for_each = var.subnets
  name = each.value.name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
  virtual_network_name = azurerm_virtual_network.three-tier-vnet.name
  address_prefixes = each.value.address_prefix
}
