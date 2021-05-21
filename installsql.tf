
resource "null_resource" "upload_db" {
    provisioner "file" {
        connection {
            type = "ssh"
            user = "azureuser"
            password = "adminuser@2021"
            host = azurerm_public_ip.atividade02-publicip.ip_address
        }
        source = "mysql"
        destination = "/home/azureuser"
    }
}

resource "null_resource" "install-mysql" {
    triggers = {
        order = azurerm_linux_virtual_machine.atividade02-vm.id
    }
    provisioner "remote-exec" {
        connection {
            type = "ssh"
            user = "azureuser"
            password = "adminuser@2021"
            host = azurerm_public_ip.atividade02-publicip.ip_address
        }
        
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y mysql-server-5.7",
            "sudo mysql < /home/azureuser/config/user.sql",
            "sudo cp -f /home/azureuser/config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf",
            "sudo service mysql restart",
            "sleep 20",
        ]
    }
}