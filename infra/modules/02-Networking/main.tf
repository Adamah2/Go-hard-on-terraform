resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = local.tags
}

resource "aws_subnet" "public_subnets" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(local.tags, { Name = "public-subnet-${count.index}" })
}

resource "aws_subnet" "private_subnets" {
  count             = local.az_count
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + local.az_count)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags              = merge(local.tags, { Name = "private-subnet-${count.index}" })
}
