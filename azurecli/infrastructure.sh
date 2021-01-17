#!/bin/bash

# Create a resource group.
az group create --name demo-bp-rg --location northeurope

az network vnet create -g demo-bp-rg -n demo-bp-vnet --address-prefix 10.0.0.0/16 \
    --subnet-name demo-bp-subent --subnet-prefix 10.0.10.0/24

# Create a virtual machine. 
az vm create \
    --resource-group demo-bp-rg \
    --name demo-server1 \
    --size Standard_B2s \
    --image win2016datacenter \
    --admin-username bpadmin \
    --admin-password Bluepri7m_Admin9 \
    --no-wait \
    --zone 1 

az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-server1

az vm create \
    --resource-group demo-bp-rg \
    --name demo-server2 \
    --size Standard_B2s \
    --image win2016datacenter \
    --admin-username bpadmin \
    --admin-password Bluepri7m_Admin9 \
    --no-wait \
    --zone 2 \

az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-server2

az vm create \
    --resource-group demo-bp-rg \
    --name demo-runtimer1 \
    --size Standard_B2s \
    --image win2016datacenter \
    --admin-username bpadmin \
    --admin-password Bluepri7m_Admin9 \
    --no-wait \
    --zone 2 \

 az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-runtimer1

az vm create \
    --resource-group demo-bp-rg \
    --name demo-runtimer2 \
    --size Standard_B2s \
    --image win2016datacenter \
    --admin-username bpadmin \
    --admin-password Bluepri7m_Admin9 \
    --no-wait \
    --zone 2 \


az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-runtimer2

#create loadbalancer
az network lb create -g demo-bp-rg -n demo-bp-lb --sku Standard

#create db
az mysql server create -l northeurope -g demo-bp-rg -n demo-bp-server -u dbadmin -p BP@dmin7 --sku-name GP_Gen5_2
