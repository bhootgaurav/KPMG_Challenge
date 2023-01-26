data "azurerm_subnet" "web_subnet" {
  name = "web_subnet-eastus2"
  virtual_network_name = azurerm_virtual_network.three-tier-vnet.name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
}

data "azurerm_subnet" "app_subnet" {
  name = "app_subnet-eastus2"
  virtual_network_name = azurerm_virtual_network.three-tier-vnet.name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
}

data "azurerm_subnet" "db_subnet" {
  name = "db_subnet-eastus2"
  virtual_network_name = azurerm_virtual_network.three-tier-vnet.name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
}