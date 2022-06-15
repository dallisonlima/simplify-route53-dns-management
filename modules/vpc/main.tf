resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.all_tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.my_vpc.id
  tags   = var.all_tags
}

resource "aws_internet_gateway_attachment" "igw_attach" {
  internet_gateway_id = aws_internet_gateway.this.id
  vpc_id              = aws_vpc.my_vpc.id
}

resource "aws_subnet" "public_subnets" {
  count                = 2
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = local.publics_subnets[count.index]
  availability_zone_id = data.aws_availability_zones.azs.zone_ids[count.index % length(data.aws_availability_zones.azs.zone_ids)]
}

resource "aws_subnet" "private_subnets" {
  count                = 2
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = local.privates_subnets[count.index]
  availability_zone_id = data.aws_availability_zones.azs.zone_ids[count.index % length(data.aws_availability_zones.azs.zone_ids)]
}

resource "aws_eip" "nat" {
  count = length(local.publics_subnets)

  vpc = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "this" {
  count         = length(local.publics_subnets.id)
  allocation_id = element(aws_eip.nat.*.id, local.privates_subnets.id)
  subnet_id     = element(local.privates_subnets.id[count.index])
}

