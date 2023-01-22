resource "azurerm_public_ip" "three-tier-publicip" {
  name = "public-ip-eastus2"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  allocation_method = "Static"
  sku = "Standard"
}