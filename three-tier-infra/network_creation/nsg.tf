resource "azurerm_network_security_group" "web_subnet-nsg" {
  name = "web_subnet-nsg"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  
  security_rule {
    name = "ssh"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  
  security_rule {
    name = "IB-80"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "80"
    }

  security_rule {
    name = "IB-443"
    priority = 103
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "443"
    }
}

resource "azurerm_subnet_network_security_group_association" "web-nsg-subnet-asso" {
  subnet_id = data.azurerm_subnet.web_subnet.id 
  network_security_group_id = azurerm_network_security_group.web_subnet-nsg.id
}

# App Subnet NSG

resource "azurerm_network_security_group" "app_subnet-nsg" {
  name = "app_subnet-nsg"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  
  security_rule {
    name = "ssh"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  
  security_rule {
    name = "IB-8080"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "10.0.1.0/24"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "8080"
    }

  security_rule {
    name = "OB-3306"
    priority = 101
    direction = "Outbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "10.0.2.0/24"
    source_port_range = "*"
    destination_address_prefix = "10.0.3.0/24"
    destination_port_range     = "3306"
    }
}

resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet-asso" {
  subnet_id = data.azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet-nsg.id
}

#DB Subnet NSG

resource "azurerm_network_security_group" "db_subnet-nsg" {
  name = "db_subnet-nsg"
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  
  security_rule {
    name = "ssh"
    priority = 101
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
    destination_address_prefix = "*"
    destination_port_range     = "22"
  }
  
  security_rule {
    name = "IB-3306"
    priority = 102
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_address_prefix = "10.0.2.0/24"
    source_port_range = "*"
    destination_address_prefix = "10.0.3.0/24"
    destination_port_range     = "3306"
    }

  security_rule {
    name = "IB-Deny-3306"
    priority = 103
    direction = "Inbound"
    access = "Deny"
    protocol = "Tcp"
    source_address_prefix = "10.0.1.0/24"
    source_port_range = "*"
    destination_address_prefix = "10.0.3.0/24"
    destination_port_range     = "3306"
    }
}

resource "azurerm_subnet_network_security_group_association" "db-nsg-subnet-asso" {
  subnet_id = data.azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet-nsg.id
}