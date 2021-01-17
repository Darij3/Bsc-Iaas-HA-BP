#Mainigie
variable rg {
  type        = string
  default     = "demo-bp-rg"
  description = "Resources created in the North Europe"
}
variable location {
  type        = string
  default     = "North Europe"
  description = "Resources created in the North Europe"
}
variable admin {
  type        = string
  default     = "bpadmin"
  description = "Creates admin user"
}

variable pass {
  type        = string
  default     = "BluePrismadmin1"
  description = "Creates password"
}