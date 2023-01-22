resource "azurerm_lb" "three-tier-elb" {
  name = "three-tier-elb-eastus2"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  sku = "Standard"
  frontend_ip_configuration {
    name = "threetier-fip"
    public_ip_address_id = azurerm_public_ip.three-tier-publicip.id
  }
}

resource "azurerm_lb_backend_address_pool" "web-bep" {
  loadbalancer_id = azurerm_lb.three-tier-elb.id
  name = "web-bep-eastus2"
}

resource "azurerm_lb_backend_address_pool_address" "web-bep-address" {
  name = "web-bep-eastus2-address"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web-bep.id
  virtual_network_id = azurerm_virtual_network.three-tier-vnet.id
  ip_address = "10.0.1.4"
}

resource "azurerm_lb_rule" "ssh" {
  loadbalancer_id = azurerm_lb.three-tier-elb.id
  name  = "ssh"
  protocol = "Tcp"
  frontend_port = 22
  backend_port = 22
  frontend_ip_configuration_name = "threetier-fip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web-bep.id]
}

resource "azurerm_lb_rule" "lbr-80" {
  loadbalancer_id = azurerm_lb.three-tier-elb.id
  name = "lbr-80"
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = "threetier-fip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web-bep.id]
}

resource "azurerm_lb_rule" "lbr-443" {
  loadbalancer_id = azurerm_lb.three-tier-elb.id
  name = "lbr-443"
  protocol  = "Tcp"
  frontend_port  = 443
  backend_port = 443
  frontend_ip_configuration_name = "threetier-fip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.web-bep.id]
}