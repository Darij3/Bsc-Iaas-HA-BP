#!/bin/bash

az vm create \
  --resource-group "demo-bp-rg" \
  --name "demo-inter1" \
  --image "Win2016Datacenter" \
  --admin-username "Demouser" \
  --admin-password "Demouser@123" \
  --location northeurope \
  --zone 1


az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-inter1


az vm create \
  --resource-group "demo-bp-rg" \
  --name "demo-inter2" \
  --image "Win2016Datacenter" \
  --admin-username "Demouser" \
  --admin-password "Demouser@123" \
  --location northeurope \
  --zone 1


az vm open-port \
    --port 80 \
    --resource-group demo-bp-rg \
    --name demo-inter2