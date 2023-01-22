resource "azurerm_virtual_network" "three-tier-vnet" {
  name = "three-tier-vnet"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  address_space = [ "10.0.0.0/16" ]
}