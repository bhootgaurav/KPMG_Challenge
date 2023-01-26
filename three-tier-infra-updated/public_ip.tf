resource "azurerm_public_ip" "three-tier-publicip" {
  name = "public-ip-eastus2"
  resource_group_name = azurerm_resource_group.three-tier-rg.name
  location = azurerm_resource_group.three-tier-rg.location
  allocation_method = "Static"
  sku = "Standard"
}