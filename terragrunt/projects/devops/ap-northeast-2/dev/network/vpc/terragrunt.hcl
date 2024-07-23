include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../../../modules/network/vpc"
}

inputs = {
  vpc = {
    cidr_block = "10.100.0.0/16"
    tags       = {
      Name = "k8s-dev"
    }
  }

  internet_gateway = {
    tags = {
      Name = "k8s-dev"
    }
  }

  public_subnets = {
    pub_2a = {
      az         = "ap-northeast-2a"
      cidr_block = "10.100.0.0/24"
      tags       = { Name = "k8s-dev-vpc-public-2a" }
    }
    pub_2b = {
      az         = "ap-northeast-2b"
      cidr_block = "10.100.1.0/24"
      tags       = { Name = "k8s-dev-vpc-public-2b" }
    }
    pub_2c = {
      az         = "ap-northeast-2c"
      cidr_block = "10.100.2.0/24"
      tags       = { Name = "k8s-dev-vpc-public-2c" }
    }
    pub_2d = {
      az         = "ap-northeast-2d"
      cidr_block = "10.100.3.0/24"
      tags       = { Name = "k8s-dev-vpc-public-2d" }
    }
  }

  public_route_table = {
    tags = { Name = "k8s-dev-vpc-public-routing" }
  }
}
