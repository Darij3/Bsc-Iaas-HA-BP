provider "azurerm" {
  features {}
}
locals {
  # The north europe has 2 availability zones
  zone = toset(["1", "2"])
}

#veido pamata grupu
resource "azurerm_resource_group" "blueprism" {
  name     = "${var.rg}"
  location = "${var.location}"
}
#veidovirtualu tikli
resource "azurerm_virtual_network" "blueprism" {
  name                = "blueprism-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.blueprism.location
  resource_group_name = azurerm_resource_group.blueprism.name
}
#veido apakstiklu
resource "azurerm_subnet" "blueprism" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.blueprism.name
  virtual_network_name = azurerm_virtual_network.blueprism.name
  address_prefixes     = ["10.0.10.0/24"]
}
#veido slodzes stabilizatoru
resource "azurerm_public_ip" "blueprism" {
  name                = "PublicIPForLB"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.blueprism.name}"
  allocation_method   = "Static"
}

resource "azurerm_lb" "blueprism" {
  name                = "LoadBalancer"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.blueprism.name}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = "${azurerm_public_ip.blueprism.id}"
  }
}
# Obligats resurs, NIC veidosanas
resource "azurerm_network_interface" "blueprism" {
  
  name                = "demo-nic"
  location            = "${var.location}"
  resource_group_name = azurerm_resource_group.blueprism.name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.blueprism.id
    private_ip_address_allocation = "Dynamic"
  }

}
#bloks, kas veido virtualas masinas 
resource "azurerm_windows_virtual_machine" "blueprism" {
  for_each              = local.zone
  name                = "demo-bp${each.value+3}"
  network_interface_ids = ["${azurerm_network_interface.blueprism[each.value].id}"]
  resource_group_name = azurerm_resource_group.blueprism.name
  location            = azurerm_resource_group.blueprism.location
  size                = "Standard_B2s"
  #zone                = local.zone
  admin_username      = "${var.admin}"
  admin_password      = "${var.pass}"
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
#bloks veido datu kratuvi
resource "azurerm_storage_account" "blueprism" {
  name                     = "bpstorage"
  resource_group_name      = "${azurerm_resource_group.blueprism.name}"
  location                 = "${azurerm_resource_group.blueprism.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

