
BLUE PRISM availability zone 1
This repository contains IaC for the Blue Prism, to install three WS2016 virtual mashine in availability zone 1.
The second zone could be created by using Azure cli. The goal is to show the two different approuches how the infrastructure could be created.
Some Terrafarm bug to add the moduele with availability zone 2.

PREREQUISITE: 
Terraform 

To install Terraform, find the appropriate package for your system and download it as a zip archive.
The installation guide can be found here:

https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started

az cli
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli


Running Terraform IaC: 
1. download the repository to your pc
2. Use follow steps in the consoul. The instruction can be found there
https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started

terraform init to initate repository

terraform validate to validate syntax

terraform  plan

terraform aply to aply the code


STRUCTURE
nain.tf

IP range provided for the vms

demo-bp-runtime1 10.0.10.6
demo-bp-runtime2 10.0.10.9
demo-bp-inter1 10.0.10.10
demo-bp-inter2 10.0.10.11
demo-bp-server1 10.0.10.8
demo-bp-server2 10.0.10.7


variables.tf

variable "location" {
    default= "northeurope"
}
variable "rg" {
    default = "demo-bp-rg"
}
variable "subnet" {
    default = "bp-subnet"
}

variable "login" {
    default = ""
}

variable "passw" {
    default = ""
}
variable "nic" {
  default = 3
}

variable "vm_name" {
  default = "demo-bp"
}

variable "vm_count" {
    default  = 3
  }


MODULE bpaz2
Module to create availability zone 2
main.tf
variable.tf


PowerShell script to create IIS

# install IIS server role
 Install-WindowsFeature -name Web-Server -IncludeManagementTools

 # remove default htm file
  remove-item  C:\inetpub\wwwroot\iisstart.htm

 # Add a new htm file that displays server name
  Add-Content -Path "C:\inetpub\wwwroot\iisstart.htm" -Value $("Hello World from " + $env:computername)

Tutorial for set up the load balancer can be found here:

https://docs.microsoft.com/en-us/azure/load-balancer/tutorial-load-balancer-standard-manage-portal

