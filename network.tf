resource "aws_vpc" "main" {
  cidr_block           = local.vpcs.main.cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = false

  tags = merge(
    {
      resouce_type = "network"
      Name         = local.vpcs.main.name
    },
    local.common_tags
  )
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.subnets.main.public.cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = merge(
    {
      resouce_type = "network"
      Name         = local.subnets.main.public.name
    },
    local.common_tags
  )
}

resource "aws_subnet" "web" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.subnets.main.web.cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = merge(
    {
      resouce_type = "network"
      Name         = local.subnets.main.web.name
    },
    local.common_tags
  )
}

resource "aws_subnet" "database" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.subnets.main.database.cidr
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = merge(
    {
      resouce_type = "network"
      Name         = local.subnets.main.database.name
    },
    local.common_tags
  )
}