module "vpc" {
  source = "./modules/vpc"
  cidr   = var.cidr_vpc

}