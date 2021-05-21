resource "azurerm_linux_virtual_machine" "atividade02-vm" {
    name                  = "virtualmachine"
    location              = azurerm_resource_group.atividade02-terraform.location
    resource_group_name   = azurerm_resource_group.atividade02-terraform.name
    size                  = "Standard_DS1_v2"
    admin_username        = "azureuser"
    admin_password        = "adminuser@2021"
    disable_password_authentication = false
    
    network_interface_ids = [azurerm_network_interface.atividade02-nic.id]
    
    os_disk {
        name              = "diskSO"
        caching           = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}
