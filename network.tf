//Criação da  Rede Virtualizada
resource "azurerm_virtual_network" "atividade02-network" {
    name                = "vnet"
    location            = azurerm_resource_group.atividade02-terraform.location
    resource_group_name = azurerm_resource_group.atividade02-terraform.name
    address_space       = ["10.0.0.0/16"]
}

//Criação da Subrede Virtualizada
resource "azurerm_subnet" "atividade02-subnet" {
    name                 = "vsubnet"
    resource_group_name  = azurerm_resource_group.atividade02-terraform.name
    virtual_network_name = azurerm_virtual_network.atividade02-network.name
    address_prefixes       = ["10.0.1.0/24"]
}

//Criação do Grupo de Segurança
resource "azurerm_network_security_group" "atividade-02nsg" {
    name                = "networksecuritygroup"
    location            = azurerm_resource_group.atividade02-terraform.location
    resource_group_name = azurerm_resource_group.atividade02-terraform.name

    security_rule {
        name                       = "mysql"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3306"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "SSH"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

//Criação do IP Publico
resource "azurerm_public_ip" "atividade02-publicip" {
    name                         = "ippublic"
    location                     = azurerm_resource_group.atividade02-terraform.location
    resource_group_name          = azurerm_resource_group.atividade02-terraform.name
    allocation_method            = "Static"
}

//Criação da Placa de Rede da VM
resource "azurerm_network_interface" "atividade02-nic" {
    name                      = "networkinterface"
    location                  = azurerm_resource_group.atividade02-terraform.location
    resource_group_name       = azurerm_resource_group.atividade02-terraform.name

    ip_configuration {
        name                          = "ipvm"
        subnet_id                     = azurerm_subnet.atividade02-subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.atividade02-publicip.id
    }
}

//Grupo de Associação
resource "azurerm_network_interface_security_group_association" "atividade-02nsg" {
    network_interface_id      = azurerm_network_interface.atividade02-nic.id
    network_security_group_id = azurerm_network_security_group.atividade-02nsg.id
}
