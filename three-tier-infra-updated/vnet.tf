resource "azurerm_virtual_network" "three-tier-vnet" {
  name = "three-tier-vnet"
  resource_group_name = azurerm_resource_group.three-tier-rg.name
  location = azurerm_resource_group.three-tier-rg.location
  address_space = [ "10.0.0.0/16" ]
}