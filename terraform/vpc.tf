module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs                                    = ["eu-west-1a", "eu-west-1b"]
  private_subnets                        = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets                         = ["10.0.101.0/24", "10.0.102.0/24"]
  database_subnets                       = ["10.0.201.0/24", "10.0.202.0/24"]

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = true
  database_subnet_group_name             = "db-subnet"

  enable_dns_hostnames                   = true
  enable_dns_support                     = true
}