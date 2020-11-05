locals {
  anywhere_cidr = "0.0.0.0/0"
  private_cidr  = "10.0.0.0/8"

  vpcs = {
    main = {
      name = "cloud-1"
      cidr = cidrsubnet(local.private_cidr, 8, 0) # 10.0.0.0/16
    }
  }

  subnets = {
    main = {
      web = {
        name = "web"
        cidr = cidrsubnet(local.vpcs.main.cidr, 8, 0) # 10.0.0.0/24
      }
      database = {
        name = "database"
        cidr = cidrsubnet(local.vpcs.main.cidr, 8, 1) # 10.0.1.0/24
      }
      public = {
        name = "public"
        cidr = cidrsubnet(local.vpcs.main.cidr, 8, 2) # 10.0.2.0/24
      }
    }
  }

  # Allowed IP Addresses for connecting to bastion host
  allowed_remote_ssh_ip_list = [
    "123.123.123.123/12",
  ]
}
