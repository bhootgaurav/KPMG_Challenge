resource "azurerm_network_interface" "db_nic" {
  name = var.db_nic_name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
  location = azurerm_resource_group.three-tier-rg.location

  ip_configuration {
    name = "db-ip"
    subnet_id = data.azurerm_subnet.db_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "db_vm" {
  name = var.db_vm_name
  resource_group_name = azurerm_resource_group.three-tier-rg.name
  location = azurerm_resource_group.three-tier-rg.location
  network_interface_ids = [ azurerm_network_interface.db_nic.id ]
  vm_size = var.vm_size
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "db-os-disk-eastus2"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = var.db_hostname
    admin_username = var.username
    #admin_password = data.azurerm_key_vault_secret.vm_password.name
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}