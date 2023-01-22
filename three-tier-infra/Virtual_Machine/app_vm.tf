resource "azurerm_network_interface" "app_nic" {
  name = var.app_nic_name
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location

  ip_configuration {
    name = "app-ip"
    subnet_id = data.azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "app_vm" {
  name = var.app_vm_name
  resource_group_name = data.azurerm_resource_group.rg-data.name
  location = data.azurerm_resource_group.rg-data.location
  network_interface_ids = [ azurerm_network_interface.app_nic.id ]
  vm_size = var.vm_size
  delete_os_disk_on_termination = true
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = "app-os-disk-eastus2"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = var.app_hostname
    admin_username = var.username
    #admin_password = data.azurerm_key_vault_secret.vm_password.name
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}