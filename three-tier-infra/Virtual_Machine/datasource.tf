data "azurerm_resource_group" "rg-data" {
  name = "three-tier-eastus2-rg"
}

data "azurerm_virtual_network" "vnet-data" {
  name = "three-tier-vnet"
  resource_group_name = data.azurerm_resource_group.rg-data.name
}

data "azurerm_subnet" "web_subnet" {
  name = "web_subnet-eastus2"
  virtual_network_name = data.azurerm_virtual_network.vnet-data.name
  resource_group_name = data.azurerm_resource_group.rg-data.name
}

data "azurerm_subnet" "app_subnet" {
  name = "app_subnet-eastus2"
  virtual_network_name = data.azurerm_virtual_network.vnet-data.name
  resource_group_name = data.azurerm_resource_group.rg-data.name
}

data "azurerm_subnet" "db_subnet" {
  name = "db_subnet-eastus2"
  virtual_network_name = data.azurerm_virtual_network.vnet-data.name
  resource_group_name = data.azurerm_resource_group.rg-data.name
}

data "azurerm_key_vault" "kv-eastus2-three" {
  name = "kv-eastus2-three"
  resource_group_name = data.azurerm_resource_group.rg-data.name
}

# data "azurerm_key_vault_secret" "vm_password" {
#   name = "vm-admin-password"
#   key_vault_id = data.azurerm_key_vault.kv-eastus2-three.id
# }