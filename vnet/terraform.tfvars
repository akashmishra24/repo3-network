resource_group_name = "Akash-SpokeRG"
dns_server_ip      = ["8.8.8.8"]
vnet_address_space = ["10.1.0.0/16"]
# subnet_name             = "subnet-1"
# vnet_name               = "vnet-1"
tags = {
    ProjectName  = "Test"
    Env          = "dev"
    BusinessUnit = "CORP"
  }
subnets = {
    subnet_1 = {
      name             = "subnet-1"
      address_prefixes = ["10.1.1.0/24"]
    }
  }
prefix = "poc"
