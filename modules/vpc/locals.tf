locals {
  subnets          = cidrsubnets(aws_vpc.my_vpc.cidr_block, 4, 4, 4, 4)
  publics_subnets  = slice(local.subnets, 0, 2)
  privates_subnets = slice(local.subnets, 2, 4)
}